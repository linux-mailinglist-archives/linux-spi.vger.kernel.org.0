Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1340BB9E17
	for <lists+linux-spi@lfdr.de>; Sat, 21 Sep 2019 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394211AbfIUNkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 21 Sep 2019 09:40:45 -0400
Received: from mout.web.de ([212.227.17.11]:45101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394165AbfIUNko (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 21 Sep 2019 09:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569073239;
        bh=n8hG64qo0b1FTqu8LVo1QtX1Ic9Wgl5C3AZxhcpCf6U=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=pHAVdobHXNhAIMUi1UzmKCFv864gtGFazqK65vx7lAvMiGx6UFulMSDEs8aGUUI74
         C+bAivYYIBz+sLKHYGwjqwjBKRdISqNEqLBlEg70387RPDO3NDR5qakAy4hm0a1H7h
         O0qADRwzVS8sUm07Oo+sCOu2vfhQAAOb+CFMqALo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilJB-1hdyyA0D1R-00cuuF; Sat, 21
 Sep 2019 15:40:39 +0200
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: xtensa-xtfpga: Use devm_platform_ioremap_resource() in
 xtfpga_spi_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <178bb78e-714f-645f-d819-5732870c4272@web.de>
Date:   Sat, 21 Sep 2019 15:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q9fUZ1U9yec7EIOvmhZTHcJuoy3N8lqdynht22stsooOhVB9O6Z
 Nq4VGKa/GQfkbb6h76H5iYZKrdp5nMBmTE4X48M10qESevv2bqdeGaHNPwtjHEOZj7RanTS
 9PLo+KqTwqNxBrZrtfn2fTL4c1prFqLowI8hTzZxh+8XyrPjpCYr/Eit1oYMxTlZXa2kVGF
 W4XUFGNIpi1bgYjcpDO7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SRNDSBcUT2I=:L1dx8VSnXNHHpYSgcznlDH
 5KK5ALjsRvcCIrI6sB9xvKhBgt13gjO0PZp5xP9J30zuoKWzYCNvW+1dlC8ZxgHETDdbVAkyb
 LaLwxNonH39R0BIcBitpK+wObJ0dlYi+497XZqky01OCt7QQhnVl+jvQj4IHnZfsy/a5sJuP3
 KPtb0MZMf4cuC7mAe/SCQrmgWZjNK7lhtcUBHU8iQ47XLtNOFTquJehenz4wjX7cXf39hvKuK
 TifM5+SDNAGzztNzqdqoFejFi8MRtOOUnmrS4XbtQQjBJfUKWMk/E1mKR0mS02Z3H+Z3RonyQ
 2yapTmrMaxATRPpwzfp+p+uCFf//DnIHAQFUEv/d5R3wHHeSfMUeF5ZRqX1yAKdnLmEptZt1Q
 5JKo8Sx8fdotjMt49GQi5MxtqU9RJ5b981MUxdxQB9YsxQnv2z/NTOvzCR4zesPURdGS+Y1QS
 hJDIZJgJOp7/NHbceGKkh6K1xYlfd8xLycr7irQme08FpjQiHaK97g+GYgh8aFOUUVgWqGW1j
 2vMZ6jTAkXwgX9zgQg1ukpXQ+dx8FkDKbQYqyDq4mdRsiTsjRJGEEPIiKMjurgvWvghPLNWYS
 fSUSF5028k4fC4B7MhOHl9LCf9qVab+26bd5q+b5jVk8wqPcpK/ZHdMRnkxRKutrfpR4Kt1Gy
 /R4HfAce5d37l+pXmuzACLzSFpB0kgRsCiMUTzX9+EFjlt6GB0jKal8zr4fHShrdZ9dJL8Ikc
 0Jha1k6N/njV9SZkDKby/KwBWQWMU4gD37IhJtntzirmWJTd4d9+1C3FrQCYCIS+dO8yxOg00
 ZC+9bKqdcFK3iuFhVIf1WEd8DglkHc1Ms33EHAh81ipwjv1mfvjQV9Hw5fyo3rdho9YSbRUAd
 2QU0X3z0c1LLLZDJipIIbhbA4pgfkApeTd0X4ocWsneXBPTfNcKLIApaahx743YL4YNgohzpd
 EYaB1pKkz3m2ZXK+SiTHLJ1QkQA19ES7UgjsXpeJi2FB5xKABln7sE9BzsaAUZmTM3t92YeLz
 Kk3flQ+f3N0OPem7FnzqxL8eR20KcFqW9J2c+l+d09woZQLo2Ata6dOsXsjMUH2fddHw3wFhb
 fHG1sXiG57msQeYhgqFyUfnLdZBwK65E3JmQfx41horiAqlAgvsbh7uyaEeZvic3U/icYd/dq
 PrRMjtMwMlL/imV0gsXJoHXN40A9Xywfp9tZN1kAnoI9x0xCDL3/0ckUe3wYifok9nRZJw39R
 G0hKFEJEGgQFPlozDxoa4ej2SQ+K/eBRkLAOWAr/E3bFRjXn81WSKnW+W4Io=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 15:35:08 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-xtensa-xtfpga.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfp=
ga.c
index 86516eb1e143..fc2b5eb7d614 100644
=2D-- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -80,7 +80,6 @@ static void xtfpga_spi_chipselect(struct spi_device *spi=
, int is_on)
 static int xtfpga_spi_probe(struct platform_device *pdev)
 {
 	struct xtfpga_spi *xspi;
-	struct resource *mem;
 	int ret;
 	struct spi_master *master;

@@ -97,14 +96,7 @@ static int xtfpga_spi_probe(struct platform_device *pde=
v)
 	xspi->bitbang.master =3D master;
 	xspi->bitbang.chipselect =3D xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] =3D xtfpga_spi_txrx_word;
-
-	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		ret =3D -ENODEV;
-		goto err;
-	}
-	xspi->regs =3D devm_ioremap_resource(&pdev->dev, mem);
+	xspi->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->regs)) {
 		ret =3D PTR_ERR(xspi->regs);
 		goto err;
=2D-
2.23.0

