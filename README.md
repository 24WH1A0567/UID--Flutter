# Raajitha Student E-Portfolio

A Flutter student e-portfolio application with login, dashboard, education, certificates, activities and projects pages.

## Requirements
- Flutter SDK
- VS Code with Flutter and Dart extensions
- Google Chrome (to run the web version)

## Run the project
Open this folder in VS Code, then run these commands in the terminal:

```bash
flutter doctor
flutter pub get
flutter run -d chrome
```

## Certificate PDFs
The app currently refers to these local certificate files. Add your own PDFs using these exact filenames inside `assets/assets/certificates/`:

- `26BVHWML1073.pptx.pdf`
- `Coursera last.pdf`
- `1. YMHFA Certificate - Accreditation-part-6.pdf`

Two other certificates open from Google Drive links already included in the source.

## Create platform folders (if needed)
If you need the Android/iOS/Windows platform scaffolding and it is not included, run this from this project folder:

```bash
flutter create .
```

## Push to GitHub
Create an empty repository on GitHub, then run the following from this folder (replace the URL with your repository URL):

```bash
git init
git add .
git commit -m "Add Flutter e-portfolio"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```
