Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A404B9DE7
	for <lists+linux-spi@lfdr.de>; Sat, 21 Sep 2019 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437805AbfIUMxT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 21 Sep 2019 08:53:19 -0400
Received: from mout.web.de ([217.72.192.78]:35987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405593AbfIUMxS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 21 Sep 2019 08:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569070372;
        bh=SCl+tmJdStyw0CQO6h+KnwtHmTZWrvSg11wccT6qzvA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=SMkRdRql9mpRjvontaJ7T//NZvV2XujWQ5rGPM4hjcwKvKu//XH1ytIrp9H9X0ITy
         B+p5gZfkO/f42zN5JEvyMbHXuNfd74Hp344MB/B0kfYKL79P2tWSazYlgZ97cV90lr
         78ahxggoNLXscqDO/GfIVcZNR8eCyu1qqXmGk8o0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPaA-1iB6un3bdK-000g3v; Sat, 21
 Sep 2019 14:52:51 +0200
To:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de>
Date:   Sat, 21 Sep 2019 14:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2RAnMwsq6u90y8BSolpVHIxB4gUiIhUjbOBK55jXz4stVkILt2a
 yGGEi2R00Bq3dxmuNkPXstj2HSdiOCHrpdNoT/ZGn74n3BCVVOS+gfnEAUw0DP7tknUIqAo
 TXd/4i8i/hNUzTZhvJYvy873vGLUAZRh3pcvGIGlWznESPzchGN//b54okAoGBOwnCRV7L8
 8neBn4GVoIsUNOJYFNhqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5uIZOtSvkE=:PM1Chy/hXGWgXhW8TIHvFO
 auEeQsBYt861j7vJYVEjZ98t/b6H+E5x/yDo/JNu1K/TvHMFhI6n2jz1C5W/zWo5uyGn+dFKO
 ccsEiC7Oz5+L6VMl2oejfz1YhEUu39+AtKp9dI7K2DAI/H0kVPzXI/RNXUeN4OJIAjjUt9/hW
 EWSU3xtjxhA7/BGLfGhMpzjOYyy9fRZnaRpmLHLkPf3+HmN8TNFjJoDbadHmbBN1Z54sTHhHp
 ScT8/97SKofTt33RBtFPFIAv5A4x86p+jDR9vIx1QQemh6I5afiunCd5WNnsACgNIt3UfOXkp
 ZJw/bkWA8s8fPFn6yNV0BaSBFaH/3uuYxZ+y0tn6+5FrENNX4ufEzO3zX0ndukseXcERg5L91
 HnPcfI7dhUyU9NCxwITOcHcdPKyW3IHgJaXtNgUQ7Xi9bwzz7dYAo6u0erZOA4c0Sdbfp8eNw
 vm4kUlIFuwBsdnTHRR/6pDgqKr3+8ROGx9v+H19ZA8CMmEnO+jAKe6vJonfzfEXwf/KGMqIwn
 lNPAxfnRab2IhfhErmLSrA3gSVCPNhmPmEJgPySRlo/8mkYM7M7qkU1m3/yKGjLN97DPcA8+h
 utJvqY3ZYnkmZY69WNuNERsmh1eS+YcQaeWQkaHj/VBPOP28waSziI6qqj62cjHShClQmL6Aw
 aHJm1pvEHsEsitL3Qv/Nw/4AUPuMTXr2vK4hyjHudDdlqy/g2qsalg7jsi422bD8ZrDncK8/v
 8t9waijpT+NNzOPJN4/GXaJO1SnzsvYdpkgfx94BqDs9OiM+5DLDJpe7CaZNsL9leGLhQO51w
 p9wVB02ALGA42+rPjLW++TqUskkINd84ape9paAKNMgyebj2Nk+57jpzUEZ1aapeYOX7JBO+r
 QtRY81nOtWxA+PMJ0ya/ecWA02toqd9imjdniONBXyPYEC8Prr31ETr7lUmhgXpNwgHcpc4B7
 pC3aan87vDhNQlwszvabLXDuxp7Ry2ODPRW+gnB+lAIfj2IygUzNUCrRJhduVj/vkpwwqBwzF
 moJDdYNKP1gH2Afmqrq6X6svNuIE1EIp8XdMh/+YM790WICN/U3KGvO/HQ/mM9GyLQZwNC51P
 xgHtCvKDk6UqDYQy546bx69gfMhHsZC+SluvJi+C77HhLFO3xLGNjA3XDG8qkHQ5NhZ4y/aY+
 h3PXgUOS4ts80Jn/Y7ToU/N6OAlDbOcikN6ycqW4NCfg+jmbMRhEPmOaqPM2P8mVVvxSsbYvQ
 8iyF6iMH+ET2kaMZDiwUTVkr0yEmeW/ZHnmxsPCF3R22+RSNrdG2OHyR/dCA=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 14:45:40 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-mt65xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6888a4dcff6d..25fe149a8d9a 100644
=2D-- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -619,7 +619,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
-	struct resource *res;
 	int i, irq, ret, addr_bits;

 	master =3D spi_alloc_master(&pdev->dev, sizeof(*mdata));
@@ -682,15 +681,7 @@ static int mtk_spi_probe(struct platform_device *pdev=
)
 	}

 	platform_set_drvdata(pdev, master);
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret =3D -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_master;
-	}
-
-	mdata->base =3D devm_ioremap_resource(&pdev->dev, res);
+	mdata->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret =3D PTR_ERR(mdata->base);
 		goto err_put_master;
=2D-
2.23.0

