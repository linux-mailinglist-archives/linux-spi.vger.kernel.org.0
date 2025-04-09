Return-Path: <linux-spi+bounces-7484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AAFA82302
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 13:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906B14A459A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA81DF99C;
	Wed,  9 Apr 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rx4Nqzjh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C520E32F
	for <linux-spi@vger.kernel.org>; Wed,  9 Apr 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196443; cv=none; b=t3aZm1h6nOVGtdFsgxMnDWdpDB2eh5XqcvBK15ROnNKQA8xt75HwfHavbyw1NbaSPO66U+2/NhO+7Dkrn3BfNO+DqJZOIXINtAZIvkBrP7iXvz7EHSKsGhlHHoa/3qBO+aJPWZ1PnGtqDCU/UsYYWRHC/yeP5ovpMsWtCE/Dhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196443; c=relaxed/simple;
	bh=E5E1BmPjEKd9c0c0GxDB+1P9MW+/Vj/8fin/Wp/T8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCwx7YnM2NKRgVgMt/SibyS/UwiCF8qhDJXBqFZKVfDXfhtPqFqmWmneFlrmONxUTlK5Mtq32WS98I7x88qGDjxQYZ1drnlWlYbWm2QBY7jQLRTwTOTejeFfijBPxLYSuaxNYGzxht+BYEvklPqdGED7sgkB+eDVYxa0IL/PNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rx4Nqzjh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3999146f8f.1
        for <linux-spi@vger.kernel.org>; Wed, 09 Apr 2025 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744196439; x=1744801239; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMsTxQJ4MJkThAh69c9vTEJavOMnmubT5UY82dUq9UM=;
        b=Rx4NqzjhVxUK2pgfGghu5EFAHEgZMr+INUhpcbd7iu/meSwnlPSyDBlrWG3VNWeh91
         4AtYw5Wpj1woLRm6asY0dcpCgAAmUfte4SUR31MoMfs4tOS+GdNwgCr4lDoEZ22wfHy6
         a8dykjEE+3LSLYWcHx/u+QIbvKaiPvy7PftSN9uQE17U4VpYawY5YrHnwQbbS1y91T+x
         z3g/a5W9q0qpYPQGIe9esf9s0JbVaRIiiHUmnFvbMCgcwhY+klRwA8rqeCDHT6G/5fi1
         0pKTQMoMdjXYBZ0uM2PSR76DBOST9JdEYZVjDQxTfnz07qEdL7tW0c4XhbLOwKUzS7IT
         RPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196439; x=1744801239;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMsTxQJ4MJkThAh69c9vTEJavOMnmubT5UY82dUq9UM=;
        b=VM6QA1fazjIIeE+rqqfKlYBmovj8jMVGsEt2IKqV1PthDaAIDW51EAT9FQGdMYovHp
         Vlexocskqfkbxpc37EdD6t1IjrZQwoUb1Aw9hXFk4+q5gNT6Ak0H20Q9w74waHA9txyZ
         o7z3DMHOgREv7jCV/XgjfRbpvbO6YTLI01S9SMw1FoxJLRhwRhdOon6AJmotVxiRw6Ge
         O+MuzjS/xszy64WY0R7pi6JTHsBGGMdKfWMYqoPF2QB3R5byQJtVILm8xjK26JKo2e8A
         on605tVws/knimC5inumXENm0o8jHkBBm/oKpv7F1DnFWysv45i7EqHmKn7uxGXY5EYG
         m6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSOMpBd4G52NicHC0HAsCRpGmg2RCE1KVqWKnjpB1ibGUTR2oydCd32Y6/qBJya7LnGABxkYm5g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZjPGBKI+GSoQA38cKcVsL9tK143U9/08FB+Xo/koCHrq6X8k
	kowdTtCP5SQu0TdJclJsgXK8j/1HOw4WxrQwdkr/yYJp7ZC4bxMOk2dlA7WPS5g=
X-Gm-Gg: ASbGncsfxYdj1larDc4j8XYqm9f4D+AmqHheFP9yv9U9YkqUaYUlVtBbs2aMGCfJgVS
	ZPTViUI3xkVQvSNyBpvjXtg2H/bOcij5SF0cQCRjul73agk9cMUh1K4gYaZ1wE5bDdQCsMjmY97
	BoSiRn3H/lBxRU59/Icls59Zu6mMAKg3yf8ZxWPM6OPetPV9hqbOzBGwm5QHv97hhBrJjrBbmRV
	S6X4pqDmmOmU8fqgMCqho7wHDlG8xgYUFfS4Pf4x2Zv2dGjTuFjf7o+t239zOmnuLxXM+UvwnQM
	jkoLmgJAlDpWHGPAwrCg0nTg8EgW00D/gAI5vfMY8uOk7w==
X-Google-Smtp-Source: AGHT+IHjGuoRPXApmr/fLNcJT+pJu0CQiZAC37N0JslksHu6yjn064Cn1Gd7YxJ1WwJwxyqUVuhsOw==
X-Received: by 2002:a05:6000:4308:b0:39d:6f2b:e74d with SMTP id ffacd0b85a97d-39d88564b64mr1742489f8f.39.1744196439615;
        Wed, 09 Apr 2025 04:00:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d89361170sm1297162f8f.2.2025.04.09.04.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:00:39 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:00:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Mark Brown <broonie@kernel.org>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: spi_amd: Fix an IS_ERR() vs NULL check in probe
Message-ID: <0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function returns NULL on error, it doesn't
return error pointers.  Update the error checking to match.

Fixes: b644c2776652 ("spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-amd-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd-pci.c b/drivers/spi/spi-amd-pci.c
index e1ecab755fe9..e5faab414c17 100644
--- a/drivers/spi/spi-amd-pci.c
+++ b/drivers/spi/spi-amd-pci.c
@@ -46,8 +46,8 @@ static int amd_spi_pci_probe(struct pci_dev *pdev,
 	io_base_addr = (io_base_addr & AMD_SPI_BASE_ADDR_MASK) + AMD_HID2_PCI_BAR_OFFSET;
 	amd_spi->io_remap_addr = devm_ioremap(dev, io_base_addr, AMD_HID2_MEM_SIZE);
 
-	if (IS_ERR(amd_spi->io_remap_addr))
-		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
+	if (!amd_spi->io_remap_addr)
+		return dev_err_probe(dev, -ENOMEM,
 				"ioremap of SPI registers failed\n");
 
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
-- 
2.47.2


