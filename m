Return-Path: <linux-spi+bounces-9254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E4B17DDE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9B8582C64
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35320D50C;
	Fri,  1 Aug 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvvef5+S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E1149DF0;
	Fri,  1 Aug 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035123; cv=none; b=ndp7fatOwYhWbTvLL3VhAryBEYmix/i0la/xCrCN3fJntuVBJcX+P7JjkEKMs4EPDM2dXO8UclUaizMsePQBqqMRr+QSCVq+CxH4V5OUar49JXOAt6OuV40fon1s0Mt87Gf+B/6IhbCV4e2p4gbBv8oCuwzI3jOX9coNYdsjgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035123; c=relaxed/simple;
	bh=gZJIQtZcU8RgAFF6bz0NixEA+52kPSSbVzusMfq/yhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bJ1A7QNIZWTjNtzy7uqg/TiTvXV+kHzcnInrafksUZAcpqthWk4+HV50EKNmHhlp7KysJXO+fLrZgV+3QMP5hkBab0BkEPkZSGUnrkdw/eOLAmBNj++BYIwq5GQKtTcfu9Eb+fs/ArZsSqg+Ycyz5usPXT4wmmHFyORMD8+tUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvvef5+S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d3f72391so11787575e9.3;
        Fri, 01 Aug 2025 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754035120; x=1754639920; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=if+jrugCoYKdMUAChMOY2irCS/mGgiPfCTcd1NEbdjY=;
        b=Pvvef5+SqjKMBGFBIEaYUYnTyMQqbXnvssiYnJb7DwN4UDOpbBB+L9LnP2A/GvEF6W
         U/5SxGC4R7XrIq4wyFrS62H5IdTQsD8wTtdEvXIzaWkDii8MH2jLKHIroZn0WS8qCntZ
         E9ajoD8mgjL8uRi3kxh5jIQR2YM6RVAqiaeYgIY/oCCS7pxn3JSOJ+RzTFaWADA8yE6v
         TOGNuzDmPX0JTKuFp2F05PxqyMXQkyaBCzGbfcltcfvNAQ6HYHV1qujWxx0FXK1uAZrg
         BKaKWnD8bgVhB7oBdHwr50s3bdrPTNs9mvllNipIYxMP8J6lehYpzUiU7hoCkfJjk6wB
         jMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754035120; x=1754639920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if+jrugCoYKdMUAChMOY2irCS/mGgiPfCTcd1NEbdjY=;
        b=Fn9BYivAyTPTkaQWEaqFoHOIi2iES0ourgAKUipoP7equR/ayygyDVPrrFqiOsPBuW
         QSL2Nqi6tCfGYTGx0/L9SDjfO5M632TrpKimF8WchLWQa98KNWStazYh6dxU457S6MUQ
         iF5nHN7hGRIQf3OAuJW4ZuTui0oJWW5Nv+BCJvHjBRZz4v7/Uomiw3WKPKYOJeQeMMoH
         xZ/LLeE411kmAJdczGLwDyS7FOYqJhvv/8M6I3rzJ6qeg3dSEXu5YmtVDQwDBrwaCkxU
         BLoUz/jZEIUrna1cTrwjt8mdad74vJyYwQ/lf7W31Sha7yXMjdZ0kj6QEaTWN2r4bsjY
         LeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPZCeQHiQ5gGtOU3/G1e9RDZoZ1ZNjxOmdeHDSsEZJZNzQHpeoQ5REmOgGfKKd2OE+Xwh6jJMVMdxmrY37@vger.kernel.org, AJvYcCWV8xk2ADyqP3tzJoM4b9Vvn4uwR1q2KEohuIC6U5ZicaefQutgFtvULo0DaA9qywFVaVyT6pq6JftQTavU@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJT0BHaFV7XIOjIIqeYdjALzSTyIKgsvq3+SW2zpOfiEVernV
	uos8la9QPQIWG1WUBBD1hLYm84OgD5Aj7kyEri9jrEpYlW37GE4gCBqqXaa0oQ==
X-Gm-Gg: ASbGncsmI1kPwYzY45UgUB5+PxAL6cYCiAHecNKnC6Nr4oKrP1af+nAzS57Vg7SDHcA
	aDjAyBo8I32qnsXA4IIkIVqfI8re1ZYkmz7oJ3lZsd7x9aFyEtYuOFKbo4zdFPUEdJ6pgAHQMdN
	LCTrpB4/qiAS1yh59Xp06OyusShWuyJ+bA09G7XUEKxMBG/VVu8RmfrIdzRPbdsCsceAEMAmqJv
	gQluC7Tf7dY8nqhFNI1MmlHH2w3Br52cQfFQbykUErKlraxQnE+TV8wpLiaK+QVgMg21jJArbi0
	txdeF2FUBviPM9gLHGt1C5R4CmbHjE4ztznG6B18hYar5rSEBbelYCR5Nue0SzDVlcxu5m8A0py
	Hvjd0+XrrcpJ5MFZvD/1HV3rrGPAuzKhZNaa0jaeKTk2Cv3foc8AcY2LJrxajOQ==
X-Google-Smtp-Source: AGHT+IHyWNxPi2finIbBIOeg6Q79VKyVKB7VXLAIFgQqUupvSjpN3TOAAtQGbNCGEpDirXnIys3JeQ==
X-Received: by 2002:a05:600c:1c21:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-458aa45997emr13496465e9.23.1754035119694;
        Fri, 01 Aug 2025 00:58:39 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0f8sm55368405e9.15.2025.08.01.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:58:39 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 01 Aug 2025 09:58:35 +0200
Subject: [PATCH] spi: spi-qpic-snand: use correct CW_PER_PAGE value for OOB
 write
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKpzjGgC/x2MQQqAIBAAvyJ7bsFMC/pKdDDdai9qChVEf086z
 sDMA4UyU4FRPJDp5MIxVGgbAW63YSNkXxmUVEYOXYtHYocl2OAxxgXdlRKufGO/qJ5IGzfoDmq
 dMlX9n6f5fT+oq7uKaQAAAA==
X-Change-ID: 20250731-qpic-snand-oob-cwpp-fix-6b26ee45c743
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_spi_program_oob() function uses only the last codeword to write
the OOB data into the flash, but it sets the CW_PER_PAGE field in the
CFG0 register as it would use all codewords.

It seems that this confuses the hardware somehow, and any access to the
flash fails with a timeout error after the function is called. The problem
can be easily reproduced with the following commands:

    # dd if=/dev/zero bs=2176 count=1 > /tmp/test.bin
    1+0 records in
    1+0 records out
    # flash_erase /dev/mtd4 0 0
    Erasing 128 Kibyte @ 0 -- 100 % complete
    # nandwrite -O /dev/mtd4 /tmp/test.bin
    Writing data to block 0 at offset 0x0
    # nanddump -o /dev/mtd4 >/dev/null
    ECC failed: 0
    ECC corrected: 0
    Number of bad blocks: 0
    Number of bbt blocks: 0
    Block size 131072, page size 2048, OOB size 128
    Dumping data starting at 0x00000000 and ending at 0x00020000...
    [   33.197605] qcom_snand 79b0000.spi: failure to read oob
    libmtd: error!: MEMREADOOB64 ioctl failed for mtd4, offset 0 (eraseblock 0)
            error 110 (Operation timed out)
    [   35.277582] qcom_snand 79b0000.spi: failure in submitting cmd descriptor
    libmtd: error!: cannot read 2048 bytes from mtd4 (eraseblock 0, offset 2048)
            error 110 (Operation timed out)
    nanddump: error!: mtd_read

Change the code to use the correct CW_PER_PAGE value to avoid this.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..5216d60e01aab26f927baaea24296571a77527cb 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1196,7 +1196,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
 	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
 
 	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
-	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
+	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
 	cfg1 = ecc_cfg->cfg1;
 	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
 	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;

---
base-commit: 926406a85ad895fbe6ee4577cdbc4f55245a0742
change-id: 20250731-qpic-snand-oob-cwpp-fix-6b26ee45c743

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


