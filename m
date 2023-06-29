Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE63742A78
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjF2QS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF2QSl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 12:18:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E12D78
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 09:18:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-345c1ed760aso3871435ab.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1688055518; x=1690647518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fqVM5yRImiBAcA8zq7R4W0rRPbmgajgEEV8HwkgmeSU=;
        b=InoJ7heCw37V/XbcBbvYk18qoOWZTkGu7BciyvO9opzLDkLUwvX9X6TzcNkipbL2GF
         Cs0KZQranyQLq75+tFqHjQsjpcbARpALo/rk0dkp6TBI6lyi43zwS/FCiTpCHjlG/woz
         Z9faZa9B+/uaDu7e+Fx+3YAC/MDMoIyXihwXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055518; x=1690647518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqVM5yRImiBAcA8zq7R4W0rRPbmgajgEEV8HwkgmeSU=;
        b=KoeJetbUVmt6+I5eUyexspaoDd+RsvnKASK6oEqUIAlxr+SAL3Mr+h4FuzSOzgWKhc
         7yB7CyKrkePbnOvKxGQmzqOg4xMy3U5aTxO3L5CukKFvaIXcHDWWzwU1YaTLI+Vkjwbg
         yiX9UqoW5e1zkOyP946VJfWT0M8vmPAzj2T7qzajRzcRd0qTZmnRDubX0gzHnKSQAt4c
         PAQrhX9fwq2FrtCATP8wyoOpkTzY65Em6WN+jZexM5cjyve/L3oa4GM3aWQa/4dTC6fL
         olWuYEMach4lMwQ5h/+kqoXMttkqM92gINNY9QvaWrFx2ZzMPRiPBsokwCAyrF1Hk7OB
         c+Dg==
X-Gm-Message-State: AC+VfDxDFBuXvSNaltyf5Z2PEasf8V50gBEK+rl2X+zOu+qwjpV0lbYQ
        waNQ7jZRGRgjvZUSCaHwnCGgpdx4MtF0gTKpR5iKSw==
X-Google-Smtp-Source: ACHHUZ5rU/XAY1A2Xe5i1KDjxdaldeL3tVTYtVT1k/RjPLK58HiLRwY06mjq4ywKGJ+yys64uIrs7QQoVU72Z0TOvm8=
X-Received: by 2002:a05:6e02:6ca:b0:345:a3c6:87ba with SMTP id
 p10-20020a056e0206ca00b00345a3c687bamr16063914ils.22.1688055518271; Thu, 29
 Jun 2023 09:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629134306.95823-1-jonas.gorski@gmail.com>
 <CAKekbeuMjUPpzfgKrxgZzFpiQ4FbeYtBtbrzkWKeBy4u2Symhg@mail.gmail.com> <CAOiHx=kh79=zBM=P8BhrU+3BHcgF71ZZdJR-hV9Tsm59=jELHw@mail.gmail.com>
In-Reply-To: <CAOiHx=kh79=zBM=P8BhrU+3BHcgF71ZZdJR-hV9Tsm59=jELHw@mail.gmail.com>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Thu, 29 Jun 2023 12:18:01 -0400
Message-ID: <CAKekbesHXh+ba6x=3_DjGH1HRmdnkn4phYG5tMobxsF_u+DBHw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: return error if neither hif_mspi nor mspi
 is available
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008accad05ff470d5c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--0000000000008accad05ff470d5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 11:38=E2=80=AFAM Jonas Gorski <jonas.gorski@gmail.c=
om> wrote:
>
> On Thu, 29 Jun 2023 at 17:07, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
> >
> > On Thu, Jun 29, 2023 at 9:43=E2=80=AFAM Jonas Gorski <jonas.gorski@gmai=
l.com> wrote:
> > >
> > > If neither a "hif_mspi" nor "mspi" resource is present, the driver wi=
ll
> > > just early exit in probe but still return success. Apart from not doi=
ng
> > > anything meaningful, this would then also lead to a null pointer acce=
ss
> > > on removal, as platform_get_drvdata() would return NULL, which it wou=
ld
> > > then try to dereferce when trying to unregister the spi master.

s/dereferce/ dereference

> > >
> > > Fix this by unconditionally calling devm_ioremap_resource(), as it ca=
n
> > > handle a NULL res and will then return a viable ERR_PTR() if we get o=
ne.
> > >
> > > The "return 0;" was previously a "goto qspi_resource_err;" where then
> > > ret was returned, but since ret was still initialized to 0 at this pl=
ace
> > > this was a valid conversion in 63c5395bb7a9 ("spi: bcm-qspi: Fix
> > > use-after-free on unbind"). The issue was not introduced by this comm=
it,
> > > only made more obvious.
> > >
> > > Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> > > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > > ---

Reviewed-by:  Kamal Dasu <kamal.dasu@broadcom.com>

> > > Found by looking a the driver while comparing it to its bindings.
> > >
> > > Only build tested, not runtested.
> > >
> > >  drivers/spi/spi-bcm-qspi.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> > > index 6b46a3b67c41..d91dfbe47aa5 100644
> > > --- a/drivers/spi/spi-bcm-qspi.c
> > > +++ b/drivers/spi/spi-bcm-qspi.c
> > > @@ -1543,13 +1543,9 @@ int bcm_qspi_probe(struct platform_device *pde=
v,
> > >                 res =3D platform_get_resource_byname(pdev, IORESOURCE=
_MEM,
> > >                                                    "mspi");
> > >
> > > -       if (res) {
> > > -               qspi->base[MSPI]  =3D devm_ioremap_resource(dev, res)=
;
> > > -               if (IS_ERR(qspi->base[MSPI]))
> > > -                       return PTR_ERR(qspi->base[MSPI]);
> > > -       } else {
> > > -               return 0;
> > > -       }
> >
> > I would rather just do this in the else case
> >
> > } else {
> >  -              return 0;
> >  +             return -ENODEV;
> > }
> >
> >  The change below does not check the return of
> > platform_get_resource_byname() in my opinion rather relies on
> > devm_ioremap_resource() doing the right thing.
>
> This is how devm_ioremap_resource() is intended to be used, see e.g.
> the example in its kernel documentation:
>
> https://elixir.bootlin.com/linux/latest/source/lib/devres.c#L167
>
> So I don't see what's wrong with relying on functions doing the right thi=
ng.
>
> Also AFAIU the appropriate return code in this case would be rather
> -EINVAL, not -ENODEV.
>
> >
> > > +       qspi->base[MSPI]  =3D devm_ioremap_resource(dev, res);
> > > +       if (IS_ERR(qspi->base[MSPI]))
> > > +               return PTR_ERR(qspi->base[MSPI]);
> > >
> > >         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "b=
spi");
> > >         if (res) {
> > > --
> > > 2.34.1
> > >
>



> Regards,
> Jonas

--0000000000008accad05ff470d5c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQZwYJKoZIhvcNAQcCoIIQWDCCEFQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2+MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUYwggQuoAMCAQICDDz1ZfY+nu573bZBWTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjIwMjFaFw0yNTA5MTAxMjIwMjFaMIGK
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xEzARBgNVBAMTCkthbWFsIERhc3UxJjAkBgkqhkiG9w0BCQEW
F2thbWFsLmRhc3VAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
qleMIXx8Zwh2WP/jpzRzyh3axDm5qIpwHevp+tTA7EztFd+5EoriRj5/goGYkJH+HbVOvY9bS1dJ
swWsylPFAKpuHPnJb+W9ZTJZnmOd6GHO+37b4rcsxsmbw9IWIy7tPWrKaLQXNjwEp/dum+FWlB8L
sCrKsoN6HxDhqzjLGMNy1lpKvkF/+5mDUeBn4hSdjLMRejcZnlnB/vk4aU/sBzFzK6gkhpoH1V+H
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBpRtDSz0hHejDnQDBFKXZ8igRtAM08n5VgKLWCq
DCzcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYyOTE2MTgz
OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAZQ1ExlvawAIXxhUr7Q6PXUlr4ntd4og1C7WuvitBtJqRTFr089EMsfiNt
A0f4FBEal6nVjb1hDZkEXFK++pQ+rWVQTEF8n97lWNMO4FYYpQK14Nlt4OlkTlQSwo1N5ywb0eFS
yrUfyVu2RaTy5zqDJVDakNl5MsSi4lksWIXtNxWiIucFbAK2NuGlSqM754Fp8opyt1vRI9WezMPH
uKSQKGdbnh+oQzrdnvFLNoFPxDSVQih9MdkJnh0V2vPgK6aW9fzNU2cNXvq/TkLzX518eEVnujSq
irrX2a2GC1bd9onIVGl0NfTCyfXmcjR5ZNxpqDhk32hxqHJLQsWIjjBy
--0000000000008accad05ff470d5c--
