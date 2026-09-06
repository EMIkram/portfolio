# Muhammad Ikram Ul Haq — Portfolio

Flutter portfolio with project mockups, screenshot galleries, experience, and contact information.

## Edit and preview

Use Flutter 3.41.4 (the version pinned in the publishing workflow).

```sh
flutter pub get
flutter run -d chrome
```

- `lib/portfolio_data.dart`: projects, contributions, screenshot paths.
- `lib/main.dart`: introduction, experience, contact, and page layout.
- `assets/images/`: portrait and project screenshots.

## Publish updates

GitHub Pages builds and publishes automatically when changes reach `master`. The workflow runs analysis and tests before deployment. In repository Settings → Pages, select **GitHub Actions** as the source.

```sh
git add lib assets web pubspec.yaml pubspec.lock test
git commit -m "Update portfolio"
git push origin master
```

Check the repository's Actions tab for deployment status. The Pages environment shows the live URL after the first successful deployment.

