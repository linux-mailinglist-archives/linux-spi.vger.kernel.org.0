Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EEFAC681
	for <lists+linux-spi@lfdr.de>; Sat,  7 Sep 2019 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbfIGLz2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Sep 2019 07:55:28 -0400
Received: from mout.web.de ([212.227.17.12]:45147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfIGLz2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 7 Sep 2019 07:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567857323;
        bh=uCBhPrOjyBKadbfdXhZIgALigPb6thWyt6L0OnaNf6o=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ONs/Eqc8vJ4EH6vTyiZs9cFSQ1VcaFYZZuDAaPSrWbhgGlS7IYdJ1ledwp7DEDIVr
         WE186PEd+BrHeIS3IQKd1W+YTN3jjNX0Ul//YNX5i1HsnMjFbZVWgtBKsVcKaLjEQ4
         AaeV71ljxg8WU+IAahgk5M6FTpnp6cP/MFClSAMo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.16.142]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MF3nL-1hukfR3sIV-00GJIc; Sat, 07
 Sep 2019 13:55:23 +0200
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi-gpio: Use PTR_ERR_OR_ZERO() in spi_gpio_request()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b2dd074a-1693-3aea-42b4-da1f5ec155c4@web.de>
Date:   Sat, 7 Sep 2019 13:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vol/cHTZVAcZ9iV8Ta9uaMh49++iaihMT5bs/zlSgl0Mbd2sX+8
 whcF7OIJVwr6EkJo81cwT2Z4cQDxecDk9iIgm9kE76m7Gqig2WYRLDoCqRNO5Da4OfXe9rD
 nZn8vVhuO9Tfgr6xJbGRTZCpyl9Vo0MUSlOJNAFxx08m1E+aM5yz4m9IwvcSO5ZMGoZSwcz
 AHFc+th+SzRnvkEOVW/PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ae8NsPK3tBk=:kca7CW0oDqiIH5pbPmy6bn
 AZd0NQ+5Un6rkZrcxnSATJhN9gRSdOXL+d7xL4m/VqIP856xxzpmaFtM0eFV1T1NywX2SBNU8
 vQ4kTCrqokyrNn9dRxId8d1qAM2WsgclxPOJhfTpcFPBmzbdUG+R5yCRfHApfpiPV9Z1AxMIy
 ps2KILPUPWgBVPgISSfh20AW9szaoxAbpsmWDmzujEGDczLgvvCa1pbFcCyUVbRA23I09KMbn
 A4MkbrerR5spiIwSpPXGA0DfN13ZiDQmJ755Fswnj258B4CMPv/M6x+9ctiTeZ8mbOMYFqJuC
 zHI3IkPeyWbniV6Nvp8LdB5bfjGeoFx763OiFN7r6lNqagoi3iMXfKrkOmZ2Ze/2j1uMyiOAe
 e088q2hOy4RjpMCs4JW3I6Q+k4/gDzY/keNnVvQOFkSBabSbumPqR2R6x3IbyEivzdEschH2v
 O6OYYqyzONfG2lzT3NM1WnG7ti33a71GQcV4gNEEOiLj570TKGgddCDk6wAVdhGmjrolfgT/Y
 qRmKfzx41+RO0iNmxtl4+ncJsLKjF0JQln3vhSEQfagt0qlN71V5/ySUFzDw3u4IRduoAaW3V
 /StHYW+Ivsh/jEzKHZgT+6/ZF1+ryfj35cPylegXRk5nO7HqaXcT+NAICNV9dGL/1HEJqMUYt
 9ZEy47PwjLN/+y/lYGTKcGpA5IJAzBK+ytG/i7BvxIPvxLidz2Ixj1bGGTmGPE9ADo9QrDnu7
 9k8U3m1MK3LMaajVS1TQsyVGYFu8zXDPvsJ9SseAaWPCH6aCbvFe4e3JVggQOZdhZ95yNZgdF
 V0rsK2SFe1f1gOZ3KGwMQc3ZbQDIV4gdtLZZtp+tjwtBG6HBKxchn9r9ulNuYU/q/oMlWDnNe
 oMLNltc3uwW6UlIPhPf6ZhcJHTkz9WTHdrxymW/Bt6wigRigo6IjUdCgyi8pusuX6jmubRFxW
 /g2lFcga5dfYIGoZAwqQGt9EnGsBwn2gDjihC13UwNInR19GRqVr4hoh9qyLDRgzCizwh3TWZ
 cdj0KV0tO9lhH8Jq4TUjUkzhyXOeZS0uk4FybI0wgF9SXDbPzWjZ/k4BBsct+T33skKas8Oix
 x9NBXePUt7XiLM0isjfqfJPw88Cr4ZaQunsc3TW8O2JB+n+WxaeD1E+IdZQ0+mX2i/RhUYjJK
 Y0F4s2GX/H1PQ3l9RvzfsHcQR3QXH7wd69TM/JfsWSpH8BN19tKmXXid6A31JDghVyj6cNv5Z
 qCKjBIWy+u+5tJHt0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Sep 2019 13:51:16 +0200

Simplify this function implementation by using a known function.

Generated by: scripts/coccinelle/api/ptr_ret.cocci

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 9eb82150666e..1d3e23ec20a6 100644
=2D-- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -290,10 +290,7 @@ static int spi_gpio_request(struct device *dev, struc=
t spi_gpio *spi_gpio)
 		return PTR_ERR(spi_gpio->miso);

 	spi_gpio->sck =3D devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(spi_gpio->sck))
-		return PTR_ERR(spi_gpio->sck);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(spi_gpio->sck);
 }

 #ifdef CONFIG_OF
=2D-
2.23.0

