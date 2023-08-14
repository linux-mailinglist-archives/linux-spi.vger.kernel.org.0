Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81177B39F
	for <lists+linux-spi@lfdr.de>; Mon, 14 Aug 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHNINz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Aug 2023 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjHNINw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Aug 2023 04:13:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC5B1
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692000804; x=1692605604; i=j.neuschaefer@gmx.net;
 bh=ShqxmfyJrhCNT2APiS66mdS2R1vDYYfHseT9w5YN74U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z2LoHenjsJxC0E44a2L6ukyOU+xl5WblHPwE9dZ0D/p8XqiqFXk3oaAzUpLGh/lh1lEiioj
 fkgIOS03jML7WwJP1GxhDH26hP1bNwxtCwqwt7UAcn99aduRRFHDkBzijF5hTQs/hHwnUpyye
 oylcLW5qrYREutAuqfOiKn8yMx1uf9tWU2oP9AjPKic6NQs3lNxl53Tlhr+5/CEjDc6YeQK52
 3+Uv/abiH+W/n3z2cBkqSxWoXT6/eyTB4HulOmio2TseBQolPQ0miqYtuvheubzONUluX5Xll
 IrGn8AeJYXh5NZCVfJv9XjyVc1N3kveYtAvdU9JfZr8CEePwq5AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1qNOEL2aer-00Rtr0; Mon, 14
 Aug 2023 10:13:24 +0200
Date:   Mon, 14 Aug 2023 10:13:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, j.neuschaefer@gmx.net,
        broonie@kernel.org
Subject: Re: [PATCH -next] spi: wpcm-fiu: switch to use
 devm_platform_ioremap_resource_byname()
Message-ID: <ZNniI8wVBQakNc0K@probook>
References: <20230803021428.3739149-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dW4RY2blFPIg03Oy"
Content-Disposition: inline
In-Reply-To: <20230803021428.3739149-1-yangyingliang@huawei.com>
X-Provags-ID: V03:K1:s/rJC8mAzow9B4sxSzt4DKsWzj0tc0zV+cgG6NHTH4UC4C7VCLb
 2GRYH7n8EjInx0gun+n0CSD3OSuHfcCMsjxbPieXNaRIBd8HMMSdTVgVhFCOTtw4qxmJKqX
 87D0pvJB3Cn05zPwXrIIbwpLu2yCMdg7ntMxO2LGzmHyTBUlruO2a2yWBUv2QzfLj4bslqf
 vDI5rKD8GaHhGYp1IAVzw==
UI-OutboundReport: notjunk:1;M01:P0:hXc/8RF9hPQ=;ha1X92aCC2JV5s2hG1024U45tpM
 BP59R9pWdtSsiQp450ZphvRf82Ucz8TQNg6oTk9YEJ5AXEXnyYdXmtLJUtlUy+Zn7n2l1PyZ1
 QBzItbIBS/XFor2+QTa3o5X5w0GnPvyod0zluvXGc4yeOGoh6VD40ZJAgTeDLCCKwQFMJEu4q
 Gb6nPT2kDEp5m4Ux1LTHPi8evaLHusnrWhLf19Oo2xFzXTMWFQpDinOLF+Ep8CkiCyjfT04f2
 p9MXGO8qQoQhnGFJt+DTL0aUqmrPF8X788GTxZ8hWB4zIMXyw9tMdhdZ47HoKRonic6R/Z3cB
 w/xBwatddoPh6+yZ+p5wX0CGYJgG7wV6EI0KahIR12sRETPkC3iPya69AizJyXt1d4i+Ugq+R
 mk/kzGihQFb4MjvBE/wJx3tL38eYJ0H9UlnoRS7n7T/khBEgGS8imyf4CoKogrlYsgaqRD0P8
 wymMkMKQlRSDyfaoKSF/4KlhRyfc+nRVxWG//385fWBLWUqm766/8m6KIFRboJEHDcz8MpaVY
 2valGsbuYE0QWe6N8FMOdqHlDROjg9ZNnWqcnAw05WZQtM9k8G3urHknTUE5W6QXskDbdt1gC
 jHMLylXxuNB9SwQp9xPMQUN6MKBgd2WnT4HXeuX9okzM/Uu0t6BYtff3mf1mPZpl6d+7MHWD8
 zTg8vVacBJiTq0KGORQ5cahrBPcFlpcEWAlOm7R4XNl6qIcDHmHjvFVScx+M3JVAm+2Ck1MfE
 ZybF0ua4Xo4MafKU3iFyC6hYIn0V7wX+gIJegWgVAt5b8xxnNTZ2ZUoSDVY1xSknrZ29ditQE
 Odp2LwC/7xzuftKCocAu6aheGsYBisXF2UaTf/L9xacc6KGBD3ksj6z1WA/7bqbrK9Ap7LnSB
 sPjG3g07eMILe2WHtkz4mcXwBhwcykdsQdIaepwjo3lYtdStM/GXL12UG4iHHpc2aQl75RiUL
 NGEAaczHX6pMUNtNKNzB2zspVS0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dW4RY2blFPIg03Oy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

thanks for your patch!

On Thu, Aug 03, 2023 at 10:14:28AM +0800, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/spi/spi-wpcm-fiu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
> index 852ffe013d32..d07a06f49204 100644
> --- a/drivers/spi/spi-wpcm-fiu.c
> +++ b/drivers/spi/spi-wpcm-fiu.c
> @@ -448,8 +448,7 @@ static int wpcm_fiu_probe(struct platform_device *pde=
v)
>  	fiu =3D spi_controller_get_devdata(ctrl);
>  	fiu->dev =3D dev;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
> -	fiu->regs =3D devm_ioremap_resource(dev, res);
> +	fiu->regs =3D devm_platform_ioremap_resource_byname(pdev, "control");

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Unfortunately, the other platform_get_resource_byname/devm_ioremap_resource
pair a few lines below can't easily be converted to
devm_platform_ioremap_resource_byname, because resource_size is needed.


Best regards,
Jonathan

--dW4RY2blFPIg03Oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmTZ4fYACgkQCDBEmo7z
X9tZRBAAwCfkWatFhzHAnUxr+fSQ9UdRO5TMf7trGILozY70i9fwTQ8aiXL7XLfO
52hRLxySdKaeyozPDWANpZ8FK/yUzTxvYVQYiZPn5RoHQFgl30wFkFQ0+A2Fv3Rr
eBmjdr3iw952j2SoR5O4tT9a84N2yhAVlHx9AxGfxnpFunfMvvoxcQ54PzjxXN+o
E/RvphD7aMM7AscCN8gr1vusfS0NzXetZq6Eew4j7g2EV+C+xy6w8PPrGYlP5t46
aMaB7YjoxO8S59gif8cWkg++LylDJpa/bvr9qG1+1OYwEuifNhI0fF6zMq3gxw7n
afHP5FWlX7iagJs3ZMpPk9KafZ923JwqucvircF77UObUQKPqsLQw9t/ODG5Y55f
xJLyt6rNdeRHzOtw8sJrhS4+joK8GzMxdlWWiy0KGdkbnaTZnb4KETl9fFjHaD8Z
op+fEbkRuAw6Ds53iKMnLoJUPKQ9XstbHBneXh1PNrUruMeU15JkO3LRxZ4qp1l8
j/R1wLoKR3b9SyT8sIRIPBpZKRpvMgCnX/5Nb/4sdhf6ZKfF7A19s1QVxRQzM4UM
73klZQi+pCVx2hajyUS7BqfWERta/+52Y/nRx3OvMcFVYyS9YTsPPAMJUIf1WXp/
KnTPmiY/5sj20wOZVnYLMrgO5eFr5riVsJcn9TwKJDNIKNI5Z/0=
=D0jc
-----END PGP SIGNATURE-----

--dW4RY2blFPIg03Oy--
