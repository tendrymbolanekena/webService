import requests
import qrcode
import os

API_URL = "http://localhost:8080/test/patient/qr"


BASE_DIR = "/usr/local/cdn/patient"


def generer_qrcode_patient():

    try:
        
        response = requests.get(API_URL, timeout=15)
        response.raise_for_status()

    
        patients = response.json()

     
        if isinstance(patients, dict):
            patients = [patients]

        for patient in patients:

            patient_id = patient.get("id")

            if not patient_id:
                print("Patient sans ID, ignoré.")
                continue

            url_patient = f"http://localhost:77/patient/{patient_id}"

            qr = qrcode.QRCode(
                version=1,
                error_correction=qrcode.constants.ERROR_CORRECT_H,
                box_size=10,
                border=4
            )

            qr.add_data(url_patient)
            qr.make(fit=True)

            img = qr.make_image(
                fill_color="black",
                back_color="white"
            )

            dossier = os.path.join(
                BASE_DIR,
                str(patient_id),
                "qrcode"
            )

            os.makedirs(dossier, exist_ok=True)

            image_path = os.path.join(
                dossier,
                f"{patient_id}-patient.jpg"
            )

            img.convert("RGB").save(
                image_path,
                format="JPEG",
                quality=95
            )

            print(f"QR Code patient {patient_id} créé : {image_path}")

    except requests.exceptions.RequestException as e:
        print(f"Erreur API : {e}")

    except Exception as e:
        print(f"Erreur : {e}")


if __name__ == "__main__":
    generer_qrcode_patient()
