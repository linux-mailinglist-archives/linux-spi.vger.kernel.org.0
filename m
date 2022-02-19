Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A024BC886
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiBSNVy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:21:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBSNVx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:21:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767B1005;
        Sat, 19 Feb 2022 05:21:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m3so14225470eda.10;
        Sat, 19 Feb 2022 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=RjPMctKZVhoEtXai563y+o3AHHthI9KS32P039dLMfk=;
        b=p5g7EqTNRVEGJHBm+irbcgUZNOH9MJijO1bkbt1rfpzfDq9RUEvYTxpQcSK/PZ+BPs
         VzbLF20uY5UmkO67j5Ne01IDs1HjTAZNygX5DC7kj57Ky4mqKpP0LJKOKAXDIJjvmy+q
         AC+m2FV/7kgtLiII/lamTyYIuHGSfsttmztZrGfYyG+0uqaqBjQUiRQYJJ62hM+/d9hN
         hO15Vtqw9L9heD36fmqYalqodZQY7nyWlxmF64AUIgeqhhZGngy0pNYSLwWgyS/dfk5Y
         +mx+aDqFSsEpxndlXnW9ehLWWBJc5zsLV9DoPvS34jEHHUiTaa0/0u4/9M0IsHL4BSEt
         mSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RjPMctKZVhoEtXai563y+o3AHHthI9KS32P039dLMfk=;
        b=JKbaJVs0GZRjaFW8nDM5ovnoi1gErypRVuI8ZhmWySaZKfjgU3KDKBMBnaSYK2iRpr
         aAUfrtapshJLa3oBCLsa+wkGK6CmqwBCYPct4YJXPSLNXquwNY0brACEqlt7KGG27XRp
         cktl+kaUltXePpJXLk50cIx7KdFW876/UrEdrBJTmjOMg1cV69vtw7MNGWVT2Ze/Fk4W
         J2PLhyiSuGjy3We85almvFMuutxCwdMgTTbSw4Yf0BpwsAvukGjnqzv/mBQCquPsokQu
         wahErrdt1G0PyZ380eCPOG06eAEIr+oCJlc/aWfqxzIuCQM4by8GwKUBRL0E74K+FT9n
         TtcQ==
X-Gm-Message-State: AOAM530DUd6KtXgHzzZHShhCteIo62B+7Zoo/skUU57Lpt4sr5k0jib9
        q5cmzckZ2fC8Eh4I6XiW7XM=
X-Google-Smtp-Source: ABdhPJy28n6lGEbuHefJ/j2tXDefEJrO4AuySKKkPDOs7GpEnD5En7td3ozqZSJw/cLIAucF12KaPg==
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id c26-20020aa7df1a000000b00409517468a9mr13048317edy.145.1645276890948;
        Sat, 19 Feb 2022 05:21:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id eq19sm5538204edb.36.2022.02.19.05.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:21:30 -0800 (PST)
Message-ID: <feac3377-4ad1-77d8-9a18-3588d80fb909@gmail.com>
Date:   Sat, 19 Feb 2022 14:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH 1/6] spi: gpio: Implement LSB First bitbang support
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
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
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


