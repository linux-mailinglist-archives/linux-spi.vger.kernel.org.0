Return-Path: <linux-spi+bounces-8263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F402AC1229
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F21B6694A
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318C18E050;
	Thu, 22 May 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVH42dSq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93D18A953;
	Thu, 22 May 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935219; cv=none; b=uiOhRGjK8KEDT/6bu6CMIjHoYO8sEesvuZFBIYiJRBFWHmA3wGI+koPmU2Bp1tywIEt4cFv0+MK/z3qTgQ1CACIm0FojBhew16d0VaGTRkAF3Zcb6j8aADCkKiiUGY0GwpZmqJ5YQl3QrosHSY45s2NPp1MiJN2nvptpNSXEfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935219; c=relaxed/simple;
	bh=gj1msL7eLOyGrh9eIOQP6qwkpOLxlgsJFT9+Z4f5HGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ut1yQm4sOa79hU0ZqF0Mi5zeOcdLu6jqwOkknp5665uLKAZyJ8HXDPgeaRxAMc+8+hOTT6C3NVg2cbOmKwkq5FoS6Heq3t9P+8aEHJWyi4kUuWnGK+pC3aJyrc0SMwsLJMHXffkGaUwmXMneroUuBKmE3exAYdftTkcLw4PvkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVH42dSq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so1399178666b.1;
        Thu, 22 May 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747935216; x=1748540016; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTeoN2ZNwpBqEf481xeP9DNeHeY17srYObiFUpBv5hM=;
        b=aVH42dSqBZhCX14C5YBPBJLponiKaNMYGhETiYKuoIKn3A+QgV7dHihyGYrbRdTJHq
         5W+fmaDqrmMC3F970+KU69S50VS72585sOl4J/gK/AxDv5jIjdMz+E06ONEUeAWdbI7G
         5FFYvoMaZYgvjl45VLqZ3i+mO3gekEYGMtFKIpFHCkLmvkAIqsMLzkbhvzbEGZVUrufx
         vF/zhl0+IzsFSSnSop7KEjRmOI3W85XVmzOtMp0TS0zmRSYrbWw2v14LTFKQksXp+6kc
         96a4/dTD8Bzrunm1M+PS6yqg9CtE0VkMRVzH5Oz1ycqxhflGs66nzKI3MnRJ292rXEpF
         aE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747935216; x=1748540016;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTeoN2ZNwpBqEf481xeP9DNeHeY17srYObiFUpBv5hM=;
        b=c3j6bfXlkhdUGBCYY1xdOEWt0CpPItNceTGCUMDdQkH7i8orDp2UXL3unzGmKM+Iw5
         Wj8buGchBvClTZyUKMoVCT0BnLqfjBXIWowMNcWC3CFwTK8xVX6k/CHmUfyCl1X+TFp6
         ZRSPxCBYEQXKUuERRC6i8qlSSrqGyzBKtrUS8DimW5KoHLTOdbU3pzubyxWtuw6oS0uf
         E3NVqORGXExSWRvAdWkqRal62rTScIpKxbN71wyfuMDZp3O+uivBXuP4mVwbzGku/jJq
         jk0vwf5TBqGdODoziKd4IaSqHw0x+eH9Kjktv9gCqQLqsUGbK9qAtQBRKIBbbeyH7WOD
         KlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU12dOgmsB//6ftNdIiNJR3XQixNlf2q1AvxHon5PgIUGaTD5U+z9CG5mX3vB6mOE8SIle/k8bYZyeH@vger.kernel.org, AJvYcCV8yO6T0cOzwH86hVhjoir6scH/Av81HcEI5PfZ2roHm5yMvJCZ8Xi6XDXY/Z0n+82cVg6tgr7TCNZCGoKn@vger.kernel.org, AJvYcCVMIOo+YPvB0j822b/EVsyvrFMeLDMo4i6LZx9yrwThMgVSr5GMuWYelRtUtLCLDzrdkFbGZWzcmv9Sl84Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYsiUAXnVdpyKMa2hyami30+W79ou27e+7y1T071IqWkIEiaG
	xBkQPdXb0jRAG7yZl1pCeO7bvbq2wV/47ehzf3U1gyQxlVGcWmglbpe5XePQzw==
X-Gm-Gg: ASbGnctWtVoTvC18lUirrqPlM32m3KZmc3fiR0FjeSR55Tf8YxUgDkp3C/5OwfXl3+c
	crXGRi+jb3jCnCtPaZakdfvjW0whvjNax2dyKL+NEEfawPxOy7TARsxffQEogMlXVZAJ3rr3WY8
	QC41IC4Zrs8XmuXKFOTrNTGufSeQyrgIkxaWhLM3flTt0Wqt+MEN2kLtxa0nj1PLCKBIdsEojGZ
	n5PM4fMJuJybUEL3/zLPF2nSgcIHsL0XEqZjLHKsw3iVRUbjZJcEP9b+/IQ+jm7TQmWoRIf+tYO
	GWsSlyliKQmgmsppXGVV5wUNJYWV/VOjy5sF2ZSA7qI2SscpvxN82pcXRoKhqQFwQa8BuR+gM9w
	x3Mej
X-Google-Smtp-Source: AGHT+IEJfDL3Z6GwGYXoUDscFxORY7Y5IAtF5LadMRdJVetuBsgTokkfHqjuWjdkON4+K8+lf3vDlg==
X-Received: by 2002:a17:907:3fa7:b0:ad5:a12d:6665 with SMTP id a640c23a62f3a-ad5a12d6948mr956070166b.33.1747935215255;
        Thu, 22 May 2025 10:33:35 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad52d06b532sm1098506966b.43.2025.05.22.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:33:34 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 22 May 2025 19:33:26 +0200
Subject: [PATCH RFC] spi: spi-qpic-snand: overestimate corrected bitflips
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-qpic-snand-overestimate-bitflips-v1-1-35c65c05068e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOVfL2gC/x3NQQrCMBBA0auUWTvQiW2RbgUP4FZcxGRSB2qaZ
 kIRSu9ucPk2/++gnIUVxmaHzJuoLLGCTg24t40To/hqMK3p294QrkkcarTR47JxZi3ysYXxJSX
 MkhSHjsj40JE7X6BmUuYg3//iAffbFZ7H8QO4AwpVdwAAAA==
X-Change-ID: 20250521-qpic-snand-overestimate-bitflips-64112df41c38
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The QPIC hardware is not capable of reporting the exact number of the
corrected bitflips, it only reports the number of the corrected bytes.
However the current code treats that as corrected bitflips which is
quite inaccurate in most cases. For example, even if the hardware reports
only one byte as corrected, that byte may have contained multiple bit
errors from one up to the maximum number of correctable bits.

Change the code to report the maximum of the possibly corrected bits,
thus allowing upper layers to do certain actions before the data gets
lost due to uncorrectable errors.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
The patch tries to address Miquel's concerns [1] about the corrected bit
error reporting capabilities of the QPIC hardware.

[1] https://lore.kernel.org/all/87h61e8kow.fsf@bootlin.com

nanbiterrs test result after the change:

  # insmod mtd_test; insmod mtd_nandbiterrs dev=4
  [   40.685251]
  [   40.685278] ==================================================
  [   40.685803] mtd_nandbiterrs: MTD device: 4
  [   40.691566] mtd_nandbiterrs: MTD device size 7602176, eraseblock=131072, page=2048, oob=128
  [   40.695528] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
  [   40.703789] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
  [   40.713655] mtd_nandbiterrs: incremental biterrors test
  [   40.716118] mtd_nandbiterrs: write_page
  [   40.722126] mtd_nandbiterrs: rewrite page
  [   40.725878] mtd_nandbiterrs: read_page
  [   41.103196] mtd_nandbiterrs: verify_page
  [   41.106915] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
  [   41.111001] mtd_nandbiterrs: Inserted biterror @ 1/7
  [   41.118007] mtd_nandbiterrs: rewrite page
  [   41.123850] mtd_nandbiterrs: read_page
  [   41.127458] qcom_snand 79b0000.spi: the number of corrected bits may be inaccurate
  [   41.130538] mtd_nandbiterrs: Read reported 4 corrected bit errors
  [   41.138060] mtd_nandbiterrs: verify_page
  [   41.144265] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
  [   41.148217] mtd_nandbiterrs: Inserted biterror @ 3/7
  [   41.155260] mtd_nandbiterrs: rewrite page
  [   41.161076] mtd_nandbiterrs: read_page
  [   41.164687] qcom_snand 79b0000.spi: the number of corrected bits may be inaccurate
  [   41.167750] mtd_nandbiterrs: Read reported 4 corrected bit errors
  [   41.175324] mtd_nandbiterrs: verify_page
  [   41.181511] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
  [   41.185456] mtd_nandbiterrs: Inserted biterror @ 5/7
  [   41.192516] mtd_nandbiterrs: rewrite page
  [   41.198301] mtd_nandbiterrs: read_page
  [   41.201949] qcom_snand 79b0000.spi: the number of corrected bits may be inaccurate
  [   41.204990] mtd_nandbiterrs: Read reported 4 corrected bit errors
  [   41.212568] mtd_nandbiterrs: verify_page
  [   41.218720] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
  [   41.222714] mtd_nandbiterrs: Inserted biterror @ 7/7
  [   41.229739] mtd_nandbiterrs: rewrite page
  [   41.235548] mtd_nandbiterrs: read_page
  [   41.239168] mtd_nandbiterrs: Read reported 4 corrected bit errors
  [   41.242252] mtd_nandbiterrs: verify_page
  [   41.248407] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
  [   41.252406] mtd_nandbiterrs: Inserted biterror @ 8/7
  [   41.259413] mtd_nandbiterrs: rewrite page
  [   41.265238] mtd_nandbiterrs: read_page
  [   41.268858] mtd_nandbiterrs: error: read failed at 0x0
  [   41.271937] mtd_nandbiterrs: After 5 biterrors per subpage, read reported error -74
  [   41.280512] mtd_nandbiterrs: finished successfully.
  [   41.284587] ==================================================
  failed to insert /lib/modules/6.15.0-rc5+/mtd_nandbiterrs.ko
  #
---
 drivers/spi/spi-qpic-snand.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 17bcd12f6cb932fdf2d968692359a0301ce4acdc..137d60081754db04ceb5db64e6f250f6477021db 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -638,6 +638,21 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc)
 			unsigned int stat;
 
 			stat = buffer & BS_CORRECTABLE_ERR_MSK;
+
+			if (stat && stat != ecc_cfg->strength) {
+				/*
+				 * The exact number of the corrected bits is
+				 * unknown because the hardware only reports
+				 * the number of the corrected bytes.
+				 *
+				 * Assume the worst case scenario and use
+				 * the maximum.
+				 */
+				dev_warn(snandc->dev,
+					 "the number of corrected bits may be inaccurate\n");
+				stat = ecc_cfg->strength;
+			}
+
 			snandc->qspi->ecc_stats.corrected += stat;
 			max_bitflips = max(max_bitflips, stat);
 		}

---
base-commit: e7f3d11567c2c79c4342791ba91c500b434ce147
change-id: 20250521-qpic-snand-overestimate-bitflips-64112df41c38

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


