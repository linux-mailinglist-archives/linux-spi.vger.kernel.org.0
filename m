Return-Path: <linux-spi+bounces-1328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201A0853977
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 19:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB69928B50D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42A605CC;
	Tue, 13 Feb 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBMCa0sX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5461605BB
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847672; cv=none; b=GNqjcbv6un/805WvInnE78Rp5ryhzcGiAHTKnSkc/btuEPfwUVxfSk8Y8EJHHZOpsnTjaYvkAdVLM7XBCJ/z8jTkCpowvhDW8sJxjG3JqXxGWJfpfXUTs03eEEJhrP08tdb2Ar02Aa3aXobWZjqAjf/QVBKW/OFOBTRipFAO/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847672; c=relaxed/simple;
	bh=GCgeemHEMjZObr29TItNfoPRYs3mnZZ8ua3W5kWq4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RM7XH2azJeJaXWiVSKYj812hgvwL2l8cUaaK9YY5hd6VPI69zYGMvGvG4yYl+JxStYie5Y+1hCLPrVb/gsh9SgqXjKoCGr0vXUL50w64cxuZ2c0RUciCjAjT8vVZ1iZUqF5Wj9yMu+UxedfUENUMCO9LW2jCoGRa2Z+e+FS/aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PBMCa0sX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so5173985a12.2
        for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707847669; x=1708452469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nvXkv/btphQ8MW54HksmzNQa+3jvkr/X94Oa7LChw8=;
        b=PBMCa0sX68glYuVtRESYoGSy5EYLyelv1inhXuWb2nqhHbhRa6+qB6CzCozLvEguq1
         kDxy3kLIyfvmCvKbE4ZTkKlm7A3XbkbTRSxR4NOMOxEiRJ2GyaOgejcVKvj3gDV3BvFb
         SECW2+G4I35sfl0vP5OjHcp060Q/QLOXFZhj99I78jcQEHXz3njEOpwGVFvo1Jy+BsxH
         aft7GnkCspwYbV40KJIpgkdQIC5E6yQjcX3sqSHZ27Pe15Kh6ftWbldAREA5YWvPHV3r
         mK6gz6yhLYf5aDHXkzXGuZFsGPPfshCPds2+hcRcXsumua8jmkcW5s+tRIn0x50s01gE
         +C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847669; x=1708452469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nvXkv/btphQ8MW54HksmzNQa+3jvkr/X94Oa7LChw8=;
        b=OYSj03nUPSh3GX1fS8e3pOclTSz4tIQGInOTwnODzwWQxzdgHohLlKqzD+P9ziD5c7
         k2+/+2kX6eIEe8lZYltUrURBnlkPVJVkRVMLCmIE8Rz6rEHiShl1x77fM/DLONnHO29v
         y+MWTQUuII7ZeS/lfysrnewg7YE9by8zd/9LfSDetCR4vn3iAO1chCSHFA3SMXtXnmJp
         rv8AKKAl6iLAlzFFxBcmB2c6KUfamK4/7KPj4ayXsD+82Aj+Fl+ly4sn7B1nhm38Qq11
         GUuPMlHNh9jnIcL8TTzO1WDTsygNDadLbkEfO6y/hQwF1gTtto9UIKz/2TYFGhoLcDjy
         MGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4KQmYdXGFvlMFxSBm2xLKrDrDtHzAXkJp51h4qNIwGse2LxnFtqKO20D5R83BjPegmZD8FDVgomHVatgMlURFsW+Cm4koADfM
X-Gm-Message-State: AOJu0Yze03rlWJCF3Z3DoofwaREOsCLZlW0Xx+lqqntFoHzcemiTwjVO
	MJ/ajtPFCCZXDpEglcJfrYLUAs4wIHCECkvuYBE/eKPZns5Pgp41oyVgksIMIec=
X-Google-Smtp-Source: AGHT+IGK8/ZBrBuhIG/7OAVoNU04LTnr1+ZqxDgeVB3c6G4zRJq+Lh+jgIpN6PATnoCEqrkuPR72MA==
X-Received: by 2002:aa7:d752:0:b0:562:1083:b7d7 with SMTP id a18-20020aa7d752000000b005621083b7d7mr311615eds.3.1707847668986;
        Tue, 13 Feb 2024 10:07:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrsKCNbf/H0BamORPHywycyrYJdRpP/MwEAylAwHFCf+pPW5AVS441po4B7fqyI8k9/YOXHdY3yHcze2IpAwPjUOYk7MRBB6D9Fxz9CMUHR8WPiocNWVasnjrrivezy6GFP8RMbcBCR1aRJNgi11vYB7EsWJTmMCro51Cq4t/HpNAE7aXCG4ys7jrY7/TeKL1iX76vc5SwjnwOCL4tp6gnko4=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fk7-20020a056402398700b00561a443a393sm2498874edb.92.2024.02.13.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:07:48 -0800 (PST)
Date: Tue, 13 Feb 2024 21:07:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: mchp-pci1xxxx: release resources on error in probe()
Message-ID: <efc92197-4023-4bfe-bc63-452e7ed112e8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call pci_release_regions(pdev) before returning on this error path.

Fixes: 3e7cfd6ad29a ("spi: mchp-pci1xxxx: Add support for DMA in SPI")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index a99db6163aec..969965d7bc98 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -776,7 +776,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 
 			ret = pci1xxxx_spi_dma_init(spi_bus, spi_sub_ptr->irq);
 			if (ret && ret != -EOPNOTSUPP)
-				return ret;
+				goto error;
 
 			/* This register is only applicable for 1st instance */
 			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
-- 
2.43.0


