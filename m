Return-Path: <linux-spi+bounces-8992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A2AF15D0
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595317B029
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CE2750F6;
	Wed,  2 Jul 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSZx4NJM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A227465A;
	Wed,  2 Jul 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459757; cv=none; b=nhMRgD18h6G92zHt+0930ObsDNpKsNwEGYCMtz6QAPcmqrhUS5YtR+Bku8kNnlNFbaISYFaUtRjqXtiyK/8KLY1PbJvCX7SXWf9ZUH0ZWdVT4VQ4VlEppsgzn4oJvNTtu71hYAgy+u0k6G++B0/Se/xonISqjfWwQgnKMkGIfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459757; c=relaxed/simple;
	bh=5LdkRLjT7J7qdCfc89AN/ahjpBUx1RI1Rq0+9/y1iWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IvMiveZaHXJdLLqxaifDiutKanW6+NINznttLIivDnZR/ZkyGv+hRU7f+PLthBMRU3YEoR07nVaKNG/LDp/w/P3mx1W7IrkSOCr4lzj2ta1itiZ0bRpHDOkrVoKB9cLQc2LQ8FDRCSBzbzrXBHlVU2JdW2ZI4625SNxgrJNq6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSZx4NJM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45377776935so51567495e9.3;
        Wed, 02 Jul 2025 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751459752; x=1752064552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2CD0gYsXDTd2ThQgj9fJWOsgMWVreEYCjm+dpQlAqc=;
        b=dSZx4NJMaECGTOQiePuqsPxzz+g7VVnZngpFxIV3VDOtG/aPYGnS+AK9l1ePTPI1n4
         MKYsUM/uNws1iMMQX5oHGUZu+NISm3K5TcIP9Kb162raw9VOht4JirvXIJexEHsOUOey
         LPy8y0RzqkoPyaFe8mvDRdNnqHUi3bZ3O48yjXE3VSrcoSDkOIj4dEnVWgmyjOCn8ePw
         ZnQlYAyJHLk25jBJ6ejKwTwXG1dn/B3oEMHEfaMaagx7FY7VMpl+A8ODn+gGg3sloG+f
         E9x37WIQJIkPGyHBzdLEpgyVNMMl2hyQxXpj/+FR8PHB2d/ndsfOFNNpDtyBcOs0HnqB
         V+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459752; x=1752064552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2CD0gYsXDTd2ThQgj9fJWOsgMWVreEYCjm+dpQlAqc=;
        b=ZQOQBjZGBLpFPCZ8sOSb440osa5z8Kp+HJCPcFEBFfRnWvPaKgR/0glWgoDET4MPPa
         92Wgu7uOaevOJYk+Fs5rzlfO1lEjtXBOugpLLG85ksppQ6b11vqq1ShLVyzgctyydI0X
         dxUzTG577oLzCx9uHV5wfoBdU8EEwb+/zL0DIgu4dxxKlMTpIIhk2K4Gie0fdFwtaWwa
         tq8olFM1yzWIHxQHKsC1ghl6jHr0XvZiZ84s9iB8kD7nS7aHGvZaLAi+o9UFy1ePV1KJ
         43mLY6FSDvRHms9zFKlBAGfG5IjPt+H1PIa/whU4M4k05YXTHTui2tin4qvnKKBrbDIF
         7/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVEsSRvvxtN3Tvs70x+LY9lDzubqLas5tc1drR/uA0f6bTJ4Blxd5C0oScUKd9HosG/Jv9z6hga16z2tggd@vger.kernel.org, AJvYcCVWRb2HtxTN6cZUu7FXxpPRfJNfeTCFdltqvbaUSGtFJOOtiAxVaJTSFyohl/MZsdzyN+gBPRjfehEW7EnQ@vger.kernel.org, AJvYcCWxxXPh460aUWUu4nzW0ae858KePlFw7f4pTwsjN6KTj/Pp2AxYyPaeyXA7Wez0EaS6j7iQj91cSY02@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QYZQ1MIcXLX8QPvGIYLw4fpKVQDf73e5fvkpuRihK7bUYOa3
	VD9NVQdno1fc23v7E5g2CTqVdaDMLNdcYOcTX0yZspifRGmesiYeMFih
X-Gm-Gg: ASbGncumctG8rpRq3eFpN62ZkQkOFC57nUCW+3x/wKrWXRMnMRAv9VdgSMg2bh5AuCn
	IVY89p2AbMsSHsNPYmNQVmzlHTIYF78rynnq9QOY+Mc5EXmqmVowvvvRm65iVG6PhZlECH0iwUa
	JZ/VLz4Wk04Rabi1b3RB/2Mx2T7dtOe2ONtceHn+kyBvqDe5+kb+ERC+RHmu6dPwe4wGOz/3EQl
	tnLVsB9OpW0QlYMsOH2cw1lt0dsl9IdwUmH5RoT7HyqWtuNzp8d0MWb6rLudy49Hq07vCLK4t+l
	6M8IugYX0jZkiLbdGpV4H7fu9Nro9sFnu96lWr1VjGYgxjHA++9wPUY/zRMjxZTU9iFFpSMy63b
	oCy922GWXb4z89XFMXfOVfkDxuQ==
X-Google-Smtp-Source: AGHT+IHDqpfjmEQSoNZgbrzWS6Oc1waO1O1w0frOX7g57VQov7+balHIgQIOc7JmRZEBYpEweI2Ymg==
X-Received: by 2002:a05:600c:1396:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-454a372160bmr25448625e9.28.1751459752127;
        Wed, 02 Jul 2025 05:35:52 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8a0sm16208688f8f.96.2025.07.02.05.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:35:51 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 02 Jul 2025 14:35:24 +0200
Subject: [PATCH v2 2/2] spi: spi-qpic-snand: add support for 8 bits ECC
 strength
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-qpic-snand-8bit-ecc-v2-2-ae2c17a30bb7@gmail.com>
References: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
In-Reply-To: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Even though the hardware supports 8 bits ECC strength, but that is not
handled in the driver yet. This change adds the missing bits in order
to allow using the driver with chips which require 8 bits ECC strength.

No functional changes intended with regard to the existing 4 bits ECC
strength support.

Tested on an IPQ9574 platform using a GigaDevice GD5F2GM7REYIG chip.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - rebase on tip of spi/for-6.17
  - rerun the tests and update the results

MTD layout:

    # cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 00080000 00020000 "0:training"
    mtd1: 00040000 00020000 "0:license"
    mtd2: 03c00000 00020000 "rootfs"
    mtd3: 03c00000 00020000 "rootfs_1"
    mtd4: 00740000 00020000 "spare"

Test results with 8 bits ECC strength:

    # dmesg | grep nand
    [    0.576213] spi-nand spi0.0: GigaDevice SPI NAND was found.
    [    0.583974] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
    # insmod mtd_test
    # insmod mtd_nandbiterrs dev=4
    [   36.455886]
    [   36.455916] ==================================================
    [   36.456443] mtd_nandbiterrs: MTD device: 4
    [   36.462086] mtd_nandbiterrs: MTD device size 7602176, eraseblock=131072, page=2048, oob=128
    [   36.466210] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
    [   36.474436] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
    [   36.484205] mtd_nandbiterrs: incremental biterrors test
    [   36.486784] mtd_nandbiterrs: write_page
    [   36.492664] mtd_nandbiterrs: rewrite page
    [   36.496416] mtd_nandbiterrs: read_page
    [   36.500284] mtd_nandbiterrs: verify_page
    [   36.503503] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
    [   36.507485] mtd_nandbiterrs: Inserted biterror @ 0/5
    [   36.514623] mtd_nandbiterrs: rewrite page
    [   36.520228] mtd_nandbiterrs: read_page
    [   36.523950] qcom_snand 79b0000.spi: Warning: due to hw limitation, the reported number of the corrected bits may be inaccurate
    [   36.527025] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   36.538412] mtd_nandbiterrs: verify_page
    [   36.544636] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
    [   36.548544] mtd_nandbiterrs: Inserted biterror @ 0/2
    [   36.555622] mtd_nandbiterrs: rewrite page
    [   36.561285] mtd_nandbiterrs: read_page
    [   36.564987] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   36.568075] mtd_nandbiterrs: verify_page
    [   36.574331] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
    [   36.578232] mtd_nandbiterrs: Inserted biterror @ 0/0
    [   36.585276] mtd_nandbiterrs: rewrite page
    [   36.591013] mtd_nandbiterrs: read_page
    [   36.594691] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   36.597763] mtd_nandbiterrs: verify_page
    [   36.604006] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
    [   36.607919] mtd_nandbiterrs: Inserted biterror @ 1/7
    [   36.614985] mtd_nandbiterrs: rewrite page
    [   36.620661] mtd_nandbiterrs: read_page
    [   36.624361] mtd_nandbiterrs: Read reported 2 corrected bit errors
    [   36.627449] mtd_nandbiterrs: verify_page
    [   36.633714] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
    [   36.637607] mtd_nandbiterrs: Inserted biterror @ 1/5
    [   36.644657] mtd_nandbiterrs: rewrite page
    [   36.650401] mtd_nandbiterrs: read_page
    [   36.654044] mtd_nandbiterrs: Read reported 2 corrected bit errors
    [   36.657137] mtd_nandbiterrs: verify_page
    [   36.663351] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
    [   36.667320] mtd_nandbiterrs: Inserted biterror @ 1/2
    [   36.674338] mtd_nandbiterrs: rewrite page
    [   36.680030] mtd_nandbiterrs: read_page
    [   36.683710] mtd_nandbiterrs: Read reported 2 corrected bit errors
    [   36.686825] mtd_nandbiterrs: verify_page
    [   36.693038] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
    [   36.697001] mtd_nandbiterrs: Inserted biterror @ 1/0
    [   36.704031] mtd_nandbiterrs: rewrite page
    [   36.709722] mtd_nandbiterrs: read_page
    [   36.713418] mtd_nandbiterrs: Read reported 2 corrected bit errors
    [   36.716513] mtd_nandbiterrs: verify_page
    [   36.722726] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
    [   36.726686] mtd_nandbiterrs: Inserted biterror @ 2/6
    [   36.733713] mtd_nandbiterrs: rewrite page
    [   36.739452] mtd_nandbiterrs: read_page
    [   36.743080] mtd_nandbiterrs: Read reported 3 corrected bit errors
    [   36.746224] mtd_nandbiterrs: verify_page
    [   36.752415] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
    [   36.756371] mtd_nandbiterrs: Inserted biterror @ 2/5
    [   36.763399] mtd_nandbiterrs: rewrite page
    [   36.769140] mtd_nandbiterrs: read_page
    [   36.772765] mtd_nandbiterrs: error: read failed at 0x0
    [   36.775909] mtd_nandbiterrs: After 9 biterrors per subpage, read reported error -74
    [   36.784522] mtd_nandbiterrs: finished successfully.
    [   36.788559] ==================================================
    failed to insert /lib/modules/6.16.0-rc3+/mtd_nandbiterrs.ko
    # insmod mtd_speedtest dev=4
    [   40.402192]
    [   40.402222] =================================================
    [   40.402758] mtd_speedtest: MTD device: 4
    [   40.408436] mtd_speedtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   40.413978] mtd_test: scanning for bad eraseblocks
    [   40.426071] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   40.634251] mtd_speedtest: testing eraseblock write speed
    [   43.925499] mtd_speedtest: eraseblock write speed is 2255 KiB/s
    [   43.925538] mtd_speedtest: testing eraseblock read speed
    [   45.902933] mtd_speedtest: eraseblock read speed is 3763 KiB/s
    [   46.105615] mtd_speedtest: testing page write speed
    [   49.405379] mtd_speedtest: page write speed is 2249 KiB/s
    [   49.405416] mtd_speedtest: testing page read speed
    [   51.395199] mtd_speedtest: page read speed is 3739 KiB/s
    [   51.598001] mtd_speedtest: testing 2 page write speed
    [   54.895222] mtd_speedtest: 2 page write speed is 2251 KiB/s
    [   54.895259] mtd_speedtest: testing 2 page read speed
    [   56.878989] mtd_speedtest: 2 page read speed is 3750 KiB/s
    [   56.879025] mtd_speedtest: Testing erase speed
    [   57.086146] mtd_speedtest: erase speed is 36616 KiB/s
    [   57.086169] mtd_speedtest: Testing 2x multi-block erase speed
    [   57.292758] mtd_speedtest: 2x multi-block erase speed is 36645 KiB/s
    [   57.292784] mtd_speedtest: Testing 4x multi-block erase speed
    [   57.500906] mtd_speedtest: 4x multi-block erase speed is 36624 KiB/s
    [   57.500931] mtd_speedtest: Testing 8x multi-block erase speed
    [   57.709020] mtd_speedtest: 8x multi-block erase speed is 36629 KiB/s
    [   57.709045] mtd_speedtest: Testing 16x multi-block erase speed
    [   57.917105] mtd_speedtest: 16x multi-block erase speed is 36635 KiB/s
    [   57.917130] mtd_speedtest: Testing 32x multi-block erase speed
    [   58.125223] mtd_speedtest: 32x multi-block erase speed is 36624 KiB/s
    [   58.125247] mtd_speedtest: Testing 64x multi-block erase speed
    [   58.333337] mtd_speedtest: 64x multi-block erase speed is 36624 KiB/s
    [   58.333362] mtd_speedtest: finished
    [   58.338756] =================================================
    # insmod mtd_readtest dev=4
    [   61.350706]
    [   61.350736] =================================================
    [   61.351262] mtd_readtest: MTD device: 4
    [   61.356945] mtd_readtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   61.360573] mtd_test: scanning for bad eraseblocks
    [   61.374497] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   61.379127] mtd_readtest: testing page read
    [   65.572558] mtd_readtest: finished
    [   65.572606] =================================================
    # insmod mtd_pagetest dev=4
    [   68.583872]
    [   68.583902] =================================================
    [   68.584427] mtd_pagetest: MTD device: 4
    [   68.590071] mtd_pagetest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   68.593769] mtd_test: scanning for bad eraseblocks
    [   68.607647] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   68.612292] mtd_pagetest: erasing whole device
    [   68.820101] mtd_pagetest: erased 58 eraseblocks
    [   68.820124] mtd_pagetest: writing whole device
    [   68.880688] mtd_pagetest: written up to eraseblock 0
    [   72.153005] mtd_pagetest: written 58 eraseblocks
    [   72.153044] mtd_pagetest: verifying all eraseblocks
    [   72.365561] mtd_pagetest: verified up to eraseblock 0
    [   84.249615] mtd_pagetest: verified 58 eraseblocks
    [   84.249651] mtd_pagetest: crosstest
    [   84.254435] mtd_pagetest: reading page at 0x0
    [   84.257127] mtd_pagetest: reading page at 0x73f800
    [   84.261639] mtd_pagetest: reading page at 0x0
    [   84.266354] mtd_pagetest: verifying pages read at 0x0 match
    [   84.270227] mtd_pagetest: crosstest ok
    [   84.275632] mtd_pagetest: erasecrosstest
    [   84.279426] mtd_pagetest: erasing block 0
    [   84.287018] mtd_pagetest: writing 1st page of block 0
    [   84.288303] mtd_pagetest: reading 1st page of block 0
    [   84.292970] mtd_pagetest: verifying 1st page of block 0
    [   84.297531] mtd_pagetest: erasing block 0
    [   84.306028] mtd_pagetest: writing 1st page of block 0
    [   84.307572] mtd_pagetest: erasing block 57
    [   84.315224] mtd_pagetest: reading 1st page of block 0
    [   84.316237] mtd_pagetest: verifying 1st page of block 0
    [   84.320834] mtd_pagetest: erasecrosstest ok
    [   84.325894] mtd_pagetest: erasetest
    [   84.330032] mtd_pagetest: erasing block 0
    [   84.337009] mtd_pagetest: writing 1st page of block 0
    [   84.338558] mtd_pagetest: erasing block 0
    [   84.346214] mtd_pagetest: reading 1st page of block 0
    [   84.347252] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [   84.351745] mtd_pagetest: erasetest ok
    [   84.357832] mtd_pagetest: finished with 0 errors
    [   84.361646] =================================================
    # insmod mtd_subpagetest dev=4
    [   87.432044]
    [   87.432074] =================================================
    [   87.432608] mtd_subpagetest: MTD device: 4
    [   87.438308] mtd_subpagetest: MTD device size 7602176, eraseblock size 131072, page size 2048, subpage size 2048, count of erase blocks 58, pages per eraseblock 64, OOB size 128
    [   87.442259] mtd_test: scanning for bad eraseblocks
    [   87.457859] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   87.665105] mtd_subpagetest: writing whole device
    [   87.666902] mtd_subpagetest: written up to eraseblock 0
    [   87.770830] mtd_subpagetest: written 58 eraseblocks
    [   87.770852] mtd_subpagetest: verifying all eraseblocks
    [   87.775608] mtd_subpagetest: verified up to eraseblock 0
    [   87.842382] mtd_subpagetest: verified 58 eraseblocks
    [   88.044974] mtd_subpagetest: verifying all eraseblocks for 0xff
    [   88.080955] mtd_subpagetest: verified up to eraseblock 0
    [   90.150157] mtd_subpagetest: verified 58 eraseblocks
    [   90.150182] mtd_subpagetest: writing whole device
    [   90.203341] mtd_subpagetest: written up to eraseblock 0
    [   93.007260] mtd_subpagetest: written 58 eraseblocks
    [   93.007295] mtd_subpagetest: verifying all eraseblocks
    [   93.041172] mtd_subpagetest: verified up to eraseblock 0
    [   94.758938] mtd_subpagetest: verified 58 eraseblocks
    [   94.961677] mtd_subpagetest: verifying all eraseblocks for 0xff
    [   94.998014] mtd_subpagetest: verified up to eraseblock 0
    [   97.063712] mtd_subpagetest: verified 58 eraseblocks
    [   97.063736] mtd_subpagetest: finished with 0 errors
    [   97.067746] =================================================
    # insmod mtd_oobtest dev=4
    [  100.081282]
    [  100.081312] =================================================
    [  100.081837] mtd_oobtest: MTD device: 4
    [  100.087544] mtd_oobtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [  100.091149] mtd_test: scanning for bad eraseblocks
    [  100.105000] mtd_test: scanned 58 eraseblocks, 0 are bad
    [  100.109528] mtd_oobtest: test 1 of 5
    [  100.317382] mtd_oobtest: writing OOBs of whole device
    [  100.317433] mtd_oobtest: written up to eraseblock 0
    [  100.322885] mtd_oobtest: written 58 eraseblocks
    [  100.326114] mtd_oobtest: verifying all eraseblocks
    [  100.330633] mtd_oobtest: verified up to eraseblock 0
    [  100.337219] mtd_oobtest: verified 58 eraseblocks
    [  100.340584] mtd_oobtest: test 2 of 5
    [  100.547912] mtd_oobtest: writing OOBs of whole device
    [  100.547960] mtd_oobtest: written up to eraseblock 0
    [  100.553439] mtd_oobtest: written 58 eraseblocks
    [  100.556617] mtd_oobtest: verifying all eraseblocks
    [  100.561133] mtd_oobtest: verified up to eraseblock 0
    [  100.566127] mtd_oobtest: verified 58 eraseblocks
    [  100.571113] mtd_oobtest: test 3 of 5
    [  100.778322] mtd_oobtest: writing OOBs of whole device
    [  100.778371] mtd_oobtest: written up to eraseblock 0
    [  100.783871] mtd_oobtest: written 58 eraseblocks
    [  100.787027] mtd_oobtest: verifying all eraseblocks
    [  100.791573] mtd_oobtest: verified up to eraseblock 0
    [  100.798192] mtd_oobtest: verified 58 eraseblocks
    [  100.801523] mtd_oobtest: test 4 of 5
    [  101.008806] mtd_oobtest: attempting to start write past end of OOB
    [  101.008829] mtd_oobtest: an error is expected...
    [  101.013894] mtd_oobtest: error occurred as expected
    [  101.018639] mtd_oobtest: attempting to start read past end of OOB
    [  101.023242] mtd_oobtest: an error is expected...
    [  101.029506] mtd_oobtest: error occurred as expected
    [  101.034208] mtd_oobtest: attempting to write past end of device
    [  101.038779] mtd_oobtest: an error is expected...
    [  101.044698] mtd_oobtest: error occurred as expected
    [  101.049543] mtd_oobtest: attempting to read past end of device
    [  101.054158] mtd_oobtest: an error is expected...
    [  101.060046] mtd_oobtest: error occurred as expected
    [  101.068326] mtd_oobtest: attempting to write past end of device
    [  101.069422] mtd_oobtest: an error is expected...
    [  101.075348] mtd_oobtest: error: wrote past end of device
    [  101.080186] mtd_oobtest: attempting to read past end of device
    [  101.085496] mtd_oobtest: an error is expected...
    [  101.091123] mtd_oobtest: error: read past end of device
    [  101.095912] mtd_oobtest: test 5 of 5
    [  101.303479] mtd_oobtest: writing OOBs of whole device
    [  101.303501] mtd_oobtest: written up to eraseblock 0
    [  101.307497] mtd_oobtest: written up to eraseblock 0
    [  101.312239] mtd_oobtest: written 57 eraseblocks
    [  101.317070] mtd_oobtest: verifying all eraseblocks
    [  101.321559] mtd_oobtest: verified up to eraseblock 0
    [  101.326471] mtd_oobtest: verified 57 eraseblocks
    [  101.331541] mtd_oobtest: finished with 2 errors
    [  101.336170] =================================================
    # insmod mtd_stresstest dev=4
    [  104.349064]
    [  104.349094] =================================================
    [  104.349621] mtd_stresstest: MTD device: 4
    [  104.355315] mtd_stresstest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [  104.362441] mtd_test: scanning for bad eraseblocks
    [  104.373017] mtd_test: scanned 58 eraseblocks, 0 are bad
    [  104.377844] mtd_stresstest: doing operations
    [  104.382952] mtd_stresstest: 0 operations done
    [  140.165792] mtd_stresstest: 1024 operations done
    [  174.351494] mtd_stresstest: 2048 operations done
    [  208.867342] mtd_stresstest: 3072 operations done
    [  244.002676] mtd_stresstest: 4096 operations done
    [  279.224074] mtd_stresstest: 5120 operations done
    [  314.134514] mtd_stresstest: 6144 operations done
    [  348.648720] mtd_stresstest: 7168 operations done
    [  384.218071] mtd_stresstest: 8192 operations done
    [  418.225256] mtd_stresstest: 9216 operations done
    [  446.919838] mtd_stresstest: finished, 10000 operations done
    [  446.919977] =================================================

Test results with forced 4 bits ECC strength:

    # dmesg | grep nand
    [    1.368711] spi-nand spi0.0: GigaDevice SPI NAND was found.
    [    1.376142] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
    [    1.396422] nand: WARNING: (null): the ECC used on your system is too weak compared to the one required by the NAND chip
    # insmod mtd_test
    # insmod mtd_nandbiterrs dev=4
    [   63.585216]
    [   63.585245] ==================================================
    [   63.585771] mtd_nandbiterrs: MTD device: 4
    [   63.591415] mtd_nandbiterrs: MTD device size 7602176, eraseblock=131072, page=2048, oob=128
    [   63.595531] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
    [   63.603756] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
    [   63.613607] mtd_nandbiterrs: incremental biterrors test
    [   63.616112] mtd_nandbiterrs: write_page
    [   63.622021] mtd_nandbiterrs: rewrite page
    [   63.625869] mtd_nandbiterrs: read_page
    [   63.629651] mtd_nandbiterrs: verify_page
    [   63.632786] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
    [   63.636851] mtd_nandbiterrs: Inserted biterror @ 0/5
    [   63.643881] mtd_nandbiterrs: rewrite page
    [   63.649581] mtd_nandbiterrs: read_page
    [   63.653259] qcom_snand 79b0000.spi: Warning: due to hw limitation, the reported number of the corrected bits may be inaccurate
    [   63.656383] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   63.667739] mtd_nandbiterrs: verify_page
    [   63.673949] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
    [   63.677874] mtd_nandbiterrs: Inserted biterror @ 0/2
    [   63.684916] mtd_nandbiterrs: rewrite page
    [   63.690642] mtd_nandbiterrs: read_page
    [   63.694357] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   63.697405] mtd_nandbiterrs: verify_page
    [   63.703648] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
    [   63.707562] mtd_nandbiterrs: Inserted biterror @ 0/0
    [   63.714606] mtd_nandbiterrs: rewrite page
    [   63.720373] mtd_nandbiterrs: read_page
    [   63.724045] mtd_nandbiterrs: Read reported 1 corrected bit errors
    [   63.727091] mtd_nandbiterrs: verify_page
    [   63.733305] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
    [   63.737287] mtd_nandbiterrs: Inserted biterror @ 1/7
    [   63.744295] mtd_nandbiterrs: rewrite page
    [   63.750016] mtd_nandbiterrs: read_page
    [   63.753696] mtd_nandbiterrs: Read reported 2 corrected bit errors
    [   63.756779] mtd_nandbiterrs: verify_page
    [   63.762994] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
    [   63.766961] mtd_nandbiterrs: Inserted biterror @ 1/5
    [   63.773980] mtd_nandbiterrs: rewrite page
    [   63.779758] mtd_nandbiterrs: read_page
    [   63.783379] mtd_nandbiterrs: error: read failed at 0x0
    [   63.786490] mtd_nandbiterrs: After 5 biterrors per subpage, read reported error -74
    [   63.795122] mtd_nandbiterrs: finished successfully.
    [   63.799139] ==================================================
    failed to insert /lib/modules/6.16.0-rc3+/mtd_nandbiterrs.ko
    # insmod mtd_speedtest dev=4
    [   67.395337]
    [   67.395368] =================================================
    [   67.395893] mtd_speedtest: MTD device: 4
    [   67.401537] mtd_speedtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   67.407131] mtd_test: scanning for bad eraseblocks
    [   67.419202] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   67.626449] mtd_speedtest: testing eraseblock write speed
    [   70.901599] mtd_speedtest: eraseblock write speed is 2266 KiB/s
    [   70.901636] mtd_speedtest: testing eraseblock read speed
    [   72.868984] mtd_speedtest: eraseblock read speed is 3782 KiB/s
    [   73.071622] mtd_speedtest: testing page write speed
    [   76.348387] mtd_speedtest: page write speed is 2265 KiB/s
    [   76.348423] mtd_speedtest: testing page read speed
    [   78.320583] mtd_speedtest: page read speed is 3772 KiB/s
    [   78.523255] mtd_speedtest: testing 2 page write speed
    [   81.797263] mtd_speedtest: 2 page write speed is 2267 KiB/s
    [   81.797298] mtd_speedtest: testing 2 page read speed
    [   83.763908] mtd_speedtest: 2 page read speed is 3783 KiB/s
    [   83.763938] mtd_speedtest: Testing erase speed
    [   83.970948] mtd_speedtest: erase speed is 36631 KiB/s
    [   83.970971] mtd_speedtest: Testing 2x multi-block erase speed
    [   84.177486] mtd_speedtest: 2x multi-block erase speed is 36662 KiB/s
    [   84.177511] mtd_speedtest: Testing 4x multi-block erase speed
    [   84.385501] mtd_speedtest: 4x multi-block erase speed is 36642 KiB/s
    [   84.385526] mtd_speedtest: Testing 8x multi-block erase speed
    [   84.593435] mtd_speedtest: 8x multi-block erase speed is 36657 KiB/s
    [   84.593459] mtd_speedtest: Testing 16x multi-block erase speed
    [   84.801368] mtd_speedtest: 16x multi-block erase speed is 36662 KiB/s
    [   84.801392] mtd_speedtest: Testing 32x multi-block erase speed
    [   85.009252] mtd_speedtest: 32x multi-block erase speed is 36671 KiB/s
    [   85.009277] mtd_speedtest: Testing 64x multi-block erase speed
    [   85.217163] mtd_speedtest: 64x multi-block erase speed is 36666 KiB/s
    [   85.217187] mtd_speedtest: finished
    [   85.222580] =================================================
    # insmod mtd_readtest dev=4
    [   88.234681]
    [   88.234711] =================================================
    [   88.235237] mtd_readtest: MTD device: 4
    [   88.240881] mtd_readtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   88.244581] mtd_test: scanning for bad eraseblocks
    [   88.258457] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   88.263101] mtd_readtest: testing page read
    [   92.383090] mtd_readtest: finished
    [   92.383133] =================================================
    # insmod mtd_pagetest dev=4
    [   95.394282]
    [   95.394312] =================================================
    [   95.394838] mtd_pagetest: MTD device: 4
    [   95.400480] mtd_pagetest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [   95.404180] mtd_test: scanning for bad eraseblocks
    [   95.418057] mtd_test: scanned 58 eraseblocks, 0 are bad
    [   95.422702] mtd_pagetest: erasing whole device
    [   95.631891] mtd_pagetest: erased 58 eraseblocks
    [   95.631913] mtd_pagetest: writing whole device
    [   95.693660] mtd_pagetest: written up to eraseblock 0
    [   98.950586] mtd_pagetest: written 58 eraseblocks
    [   98.950613] mtd_pagetest: verifying all eraseblocks
    [   99.160485] mtd_pagetest: verified up to eraseblock 0
    [  110.990791] mtd_pagetest: verified 58 eraseblocks
    [  110.990827] mtd_pagetest: crosstest
    [  110.995550] mtd_pagetest: reading page at 0x0
    [  110.998293] mtd_pagetest: reading page at 0x73f800
    [  111.002807] mtd_pagetest: reading page at 0x0
    [  111.007522] mtd_pagetest: verifying pages read at 0x0 match
    [  111.011403] mtd_pagetest: crosstest ok
    [  111.016808] mtd_pagetest: erasecrosstest
    [  111.020602] mtd_pagetest: erasing block 0
    [  111.028184] mtd_pagetest: writing 1st page of block 0
    [  111.029475] mtd_pagetest: reading 1st page of block 0
    [  111.034192] mtd_pagetest: verifying 1st page of block 0
    [  111.038660] mtd_pagetest: erasing block 0
    [  111.047202] mtd_pagetest: writing 1st page of block 0
    [  111.048745] mtd_pagetest: erasing block 57
    [  111.056403] mtd_pagetest: reading 1st page of block 0
    [  111.057411] mtd_pagetest: verifying 1st page of block 0
    [  111.062010] mtd_pagetest: erasecrosstest ok
    [  111.067069] mtd_pagetest: erasetest
    [  111.071208] mtd_pagetest: erasing block 0
    [  111.078182] mtd_pagetest: writing 1st page of block 0
    [  111.079731] mtd_pagetest: erasing block 0
    [  111.087390] mtd_pagetest: reading 1st page of block 0
    [  111.088420] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [  111.092920] mtd_pagetest: erasetest ok
    [  111.099010] mtd_pagetest: finished with 0 errors
    [  111.102823] =================================================
    # insmod mtd_subpagetest dev=4
    [  114.153409]
    [  114.153439] =================================================
    [  114.154040] mtd_subpagetest: MTD device: 4
    [  114.159609] mtd_subpagetest: MTD device size 7602176, eraseblock size 131072, page size 2048, subpage size 2048, count of erase blocks 58, pages per eraseblock 64, OOB size 128
    [  114.163640] mtd_test: scanning for bad eraseblocks
    [  114.179227] mtd_test: scanned 58 eraseblocks, 0 are bad
    [  114.386310] mtd_subpagetest: writing whole device
    [  114.388103] mtd_subpagetest: written up to eraseblock 0
    [  114.491652] mtd_subpagetest: written 58 eraseblocks
    [  114.491674] mtd_subpagetest: verifying all eraseblocks
    [  114.496440] mtd_subpagetest: verified up to eraseblock 0
    [  114.562429] mtd_subpagetest: verified 58 eraseblocks
    [  114.765104] mtd_subpagetest: verifying all eraseblocks for 0xff
    [  114.800709] mtd_subpagetest: verified up to eraseblock 0
    [  116.847270] mtd_subpagetest: verified 58 eraseblocks
    [  116.847297] mtd_subpagetest: writing whole device
    [  116.900498] mtd_subpagetest: written up to eraseblock 0
    [  119.700656] mtd_subpagetest: written 58 eraseblocks
    [  119.700691] mtd_subpagetest: verifying all eraseblocks
    [  119.734145] mtd_subpagetest: verified up to eraseblock 0
    [  121.450922] mtd_subpagetest: verified 58 eraseblocks
    [  121.653763] mtd_subpagetest: verifying all eraseblocks for 0xff
    [  121.689374] mtd_subpagetest: verified up to eraseblock 0
    [  123.731984] mtd_subpagetest: verified 58 eraseblocks
    [  123.732019] mtd_subpagetest: finished with 0 errors
    [  123.736055] =================================================
    # insmod mtd_oobtest dev=4
    [  126.749516]
    [  126.749545] =================================================
    [  126.750071] mtd_oobtest: MTD device: 4
    [  126.755780] mtd_oobtest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [  126.759382] mtd_test: scanning for bad eraseblocks
    [  126.773237] mtd_test: scanned 58 eraseblocks, 0 are bad
    [  126.777783] mtd_oobtest: test 1 of 5
    [  126.985466] mtd_oobtest: writing OOBs of whole device
    [  126.985516] mtd_oobtest: written up to eraseblock 0
    [  126.990968] mtd_oobtest: written 58 eraseblocks
    [  126.994196] mtd_oobtest: verifying all eraseblocks
    [  126.998718] mtd_oobtest: verified up to eraseblock 0
    [  127.005311] mtd_oobtest: verified 58 eraseblocks
    [  127.008669] mtd_oobtest: test 2 of 5
    [  127.216023] mtd_oobtest: writing OOBs of whole device
    [  127.216071] mtd_oobtest: written up to eraseblock 0
    [  127.221523] mtd_oobtest: written 58 eraseblocks
    [  127.224754] mtd_oobtest: verifying all eraseblocks
    [  127.229245] mtd_oobtest: verified up to eraseblock 0
    [  127.234235] mtd_oobtest: verified 58 eraseblocks
    [  127.239225] mtd_oobtest: test 3 of 5
    [  127.446528] mtd_oobtest: writing OOBs of whole device
    [  127.446576] mtd_oobtest: written up to eraseblock 0
    [  127.452046] mtd_oobtest: written 58 eraseblocks
    [  127.455258] mtd_oobtest: verifying all eraseblocks
    [  127.459779] mtd_oobtest: verified up to eraseblock 0
    [  127.466398] mtd_oobtest: verified 58 eraseblocks
    [  127.469729] mtd_oobtest: test 4 of 5
    [  127.677052] mtd_oobtest: attempting to start write past end of OOB
    [  127.677076] mtd_oobtest: an error is expected...
    [  127.682112] mtd_oobtest: error occurred as expected
    [  127.686911] mtd_oobtest: attempting to start read past end of OOB
    [  127.691489] mtd_oobtest: an error is expected...
    [  127.697753] mtd_oobtest: error occurred as expected
    [  127.702424] mtd_oobtest: attempting to write past end of device
    [  127.707038] mtd_oobtest: an error is expected...
    [  127.712928] mtd_oobtest: error occurred as expected
    [  127.717803] mtd_oobtest: attempting to read past end of device
    [  127.722391] mtd_oobtest: an error is expected...
    [  127.728304] mtd_oobtest: error occurred as expected
    [  127.736579] mtd_oobtest: attempting to write past end of device
    [  127.737669] mtd_oobtest: an error is expected...
    [  127.743593] mtd_oobtest: error: wrote past end of device
    [  127.748433] mtd_oobtest: attempting to read past end of device
    [  127.753750] mtd_oobtest: an error is expected...
    [  127.759371] mtd_oobtest: error: read past end of device
    [  127.764178] mtd_oobtest: test 5 of 5
    [  127.971793] mtd_oobtest: writing OOBs of whole device
    [  127.971818] mtd_oobtest: written up to eraseblock 0
    [  127.975844] mtd_oobtest: written up to eraseblock 0
    [  127.980557] mtd_oobtest: written 57 eraseblocks
    [  127.985376] mtd_oobtest: verifying all eraseblocks
    [  127.989876] mtd_oobtest: verified up to eraseblock 0
    [  127.994787] mtd_oobtest: verified 57 eraseblocks
    [  127.999857] mtd_oobtest: finished with 2 errors
    [  128.004487] =================================================
    # insmod mtd_stresstest dev=4
    [  131.019042]
    [  131.019073] =================================================
    [  131.019598] mtd_stresstest: MTD device: 4
    [  131.025297] mtd_stresstest: MTD device size 7602176, eraseblock size 131072, page size 2048, count of eraseblocks 58, pages per eraseblock 64, OOB size 128
    [  131.032408] mtd_test: scanning for bad eraseblocks
    [  131.043029] mtd_test: scanned 58 eraseblocks, 0 are bad
    [  131.047827] mtd_stresstest: doing operations
    [  131.052930] mtd_stresstest: 0 operations done
    [  165.463575] mtd_stresstest: 1024 operations done
    [  199.990286] mtd_stresstest: 2048 operations done
    [  234.143126] mtd_stresstest: 3072 operations done
    [  268.463135] mtd_stresstest: 4096 operations done
    [  303.656634] mtd_stresstest: 5120 operations done
    [  339.128887] mtd_stresstest: 6144 operations done
    [  372.348801] mtd_stresstest: 7168 operations done
    [  407.928145] mtd_stresstest: 8192 operations done
    [  442.519136] mtd_stresstest: 9216 operations done
    [  469.876283] mtd_stresstest: finished, 10000 operations done
    [  469.876423] =================================================
---
 drivers/spi/spi-qpic-snand.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7219bcaf4055aaa46ee1016ca9bc77aaeef191e4..b711c8be42c1f76029497b0c17d00cd8e52f5aa2 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -277,9 +277,22 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 		goto err_free_ecc_cfg;
 	}
 
-	if (ecc_cfg->strength != 4) {
+	switch (ecc_cfg->strength) {
+	case 4:
+		ecc_cfg->ecc_mode = ECC_MODE_4BIT;
+		ecc_cfg->ecc_bytes_hw = 7;
+		ecc_cfg->spare_bytes = 4;
+		break;
+
+	case 8:
+		ecc_cfg->ecc_mode = ECC_MODE_8BIT;
+		ecc_cfg->ecc_bytes_hw = 13;
+		ecc_cfg->spare_bytes = 2;
+		break;
+
+	default:
 		dev_err(snandc->dev,
-			"only 4 bits ECC strength is supported\n");
+			"only 4 or 8 bits ECC strength is supported\n");
 		ret = -EOPNOTSUPP;
 		goto err_free_ecc_cfg;
 	}
@@ -296,8 +309,6 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	nand->ecc.ctx.priv = ecc_cfg;
 	snandc->qspi->mtd = mtd;
 
-	ecc_cfg->ecc_bytes_hw = 7;
-	ecc_cfg->spare_bytes = 4;
 	ecc_cfg->bbm_size = 1;
 	ecc_cfg->bch_enabled = true;
 	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
@@ -343,7 +354,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 			       FIELD_PREP(ECC_SW_RESET, 0) |
 			       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
 			       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
-			       FIELD_PREP(ECC_MODE_MASK, ECC_MODE_4BIT) |
+			       FIELD_PREP(ECC_MODE_MASK, ecc_cfg->ecc_mode) |
 			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
 
 	ecc_cfg->ecc_buf_cfg = FIELD_PREP(NUM_STEPS_MASK, 0x203);

-- 
2.50.0


