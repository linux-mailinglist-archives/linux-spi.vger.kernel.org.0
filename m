Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9F4BEBC5
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiBUU1R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiBUU1Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAE237C0;
        Mon, 21 Feb 2022 12:26:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w3so31749867edu.8;
        Mon, 21 Feb 2022 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=RjPMctKZVhoEtXai563y+o3AHHthI9KS32P039dLMfk=;
        b=SfsZUk2M7qcqxUkjTJ5QfavmgyzPhsJixnMUI3gaxFpYaeZlzxmnyngXQogbe0tiMA
         WlXpTPz5Nldjh+i6WHccrSF0LyiydOymUlRdDrOWBhLsUPbiiSKie5skMKm4c9CUh/fK
         j/iSXF4lcJnQOA2luGfscPcsnKyD6LVI3wlbcEUurIHCoWNnVa3Y4aFm5TpsQuRHsriB
         3sm2QB211MPU1ATTvZ1vdZdjNpcnVHIsKsdBfvlISZJYhoC7Y62UzWAbliI30nlIWI1c
         mHytIXPnplQDt0xL5l5VvE+k0V8uThOLdK+pW+MgEvrUdRSDPMJ7SmPwj6aF29nXfL3I
         9esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RjPMctKZVhoEtXai563y+o3AHHthI9KS32P039dLMfk=;
        b=RLyDwIgNvO7gB4fN1K2NIOqCs20k3ASEFRdLZTv7Cu6LU/pV5P45vwTDUabMZIilvc
         WhBOe+ySDbpteX37/JbQUGuX+URp2nBq7IhuQFAVKxF0Mu21z1ZpJDx6SzPto9fy9gQe
         OF346JL3v+sMDgZUrNw9mA78L3C3RqPxgrMudl67H6ZpTIXQ0pB/Kz0zC4i3/NKy44QQ
         TX7fb2rivPZ+W9qzoPis4qMDPE/RaTQkgm3FUDXh62p0TvlsgVekkMeNOCsEWj/stoxe
         vQBItAAL/lG5kNp5MeukQsQjJH+a6LIsySFs8+7IMuXntnM/uIpGk51b2SYISD+4BTyB
         7+rg==
X-Gm-Message-State: AOAM533jmnvNPVk5k/h7tbt9KhoFZkStJV5p1D4I2EyRNBm8GOQdYtFq
        ik5NOySJvwJLiI0u0jzzZ9Q=
X-Google-Smtp-Source: ABdhPJynRraUwluYQEbFA05yc6hpmw0TfvGgTwGFEVbljIPmKA/MOhfvZT0G1xeWqpd8aU6E73rhLg==
X-Received: by 2002:a05:6402:4415:b0:410:d28b:1e14 with SMTP id y21-20020a056402441500b00410d28b1e14mr23074770eda.211.1645475211277;
        Mon, 21 Feb 2022 12:26:51 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id bo11sm5444587ejb.24.2022.02.21.12.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:50 -0800 (PST)
Message-ID: <6389315a-30ee-8106-209f-bf2462d12971@gmail.com>
Date:   Mon, 21 Feb 2022 21:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 1/6] spi: gpio: Implement LSB First bitbang support
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
Conditionally call them from all the spi-gpio txrx_word callbacks.

Some alternatives to this implementation approach were discussed back
then [0], but eventually it was considered reasonable.

[0] https://lore.kernel.org/linux-arm-kernel/20191212033952.5967-8-afaerber@suse.de/

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi-bitbang-txrx.h | 66 ++++++++++++++++++++++++++++++++++
 drivers/spi/spi-gpio.c         | 42 +++++++++++++++++-----
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index ae61d72c7..267342dfa 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -41,6 +41,8 @@
  * chips need ... there may be several reasons you'd need to tweak timings
  * in these routines, not just to make it faster or slower to match a
  * particular CPU clock rate.
+ *
+ * ToDo: Maybe the bitrev macros can be used to improve the code?
  */
 
 static inline u32
@@ -106,3 +108,67 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 	}
 	return word;
 }
+
+static inline u32
+bitbang_txrx_le_cpha0(struct spi_device *spi,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	u32 oldbit = !(word & 1);
+	/* clock starts at inactive polarity */
+	for (; likely(bits); bits--) {
+
+		/* setup LSB (to slave) on trailing edge */
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & 1) != oldbit) {
+				setmosi(spi, word & 1);
+				oldbit = word & 1;
+			}
+		}
+		spidelay(nsecs);	/* T(setup) */
+
+		setsck(spi, !cpol);
+		spidelay(nsecs);
+
+		/* sample LSB (from slave) on leading edge */
+		word >>= 1;
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi) << (bits - 1);
+		setsck(spi, cpol);
+	}
+	return word;
+}
+
+static inline u32
+bitbang_txrx_le_cpha1(struct spi_device *spi,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
+
+	u32 oldbit = !(word & 1);
+	/* clock starts at inactive polarity */
+	for (; likely(bits); bits--) {
+
+		/* setup LSB (to slave) on leading edge */
+		setsck(spi, !cpol);
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & 1) != oldbit) {
+				setmosi(spi, word & 1);
+				oldbit = word & 1;
+			}
+		}
+		spidelay(nsecs); /* T(setup) */
+
+		setsck(spi, cpol);
+		spidelay(nsecs);
+
+		/* sample LSB (from slave) on trailing edge */
+		word >>= 1;
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi) << (bits - 1);
+	}
+	return word;
+}
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 0584f4d2f..4b12c4964 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -135,25 +135,37 @@ static inline int getmiso(const struct spi_device *spi)
 static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
 }
 
 /*
@@ -170,28 +182,40 @@ static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
 }
 
 /*----------------------------------------------------------------------*/
@@ -378,7 +402,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
-			    SPI_CS_HIGH;
+			    SPI_CS_HIGH | SPI_LSB_FIRST;
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
 		 *
-- 
2.35.1

