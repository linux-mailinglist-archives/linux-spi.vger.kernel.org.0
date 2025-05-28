Return-Path: <linux-spi+bounces-8322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78106AC633C
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 09:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C397A17A6
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615B244678;
	Wed, 28 May 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TN3YpbX0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6112CCDB
	for <linux-spi@vger.kernel.org>; Wed, 28 May 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418220; cv=none; b=jSd4DujN8ICuC/4V3m140WIziyq2rqo2xLnxHIEgDpn7q7vX5tFW6kMECMZ7DY4mLJlTOTS5/DQ06eWTk4QAj6Xn5vcqnPgQlr45vwuQ1PjxoMvnHmUOckdO+F1IR2fCPbb3cvT+L/hw9jYZcS+iApF+YYHIFgVMB57G0LfdrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418220; c=relaxed/simple;
	bh=pPI/KLTmzF+/yfU5LSdgSgrlZBoPC24xdVdYbc4iefI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZjqR146IfmZlGMeyAeTwtFqcl1IcVe8ElRumxIM+wUsRG2JFpLDMwvuSp15kFxklmfssnZrbDwqMtGn5fPQ0RGHLqVCNpyv1PSy+9J9R4learNGfrvcOqQEv8AIEUXrAngrx8wp57qw3KVRAaBTLzixfclM0Tk11GORaRo2DBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TN3YpbX0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso2997709f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 28 May 2025 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748418217; x=1749023017; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EQWlfCjtDnfKxeAaJ1r+er3G/sxFT4dgHxXDNXVy+0=;
        b=TN3YpbX0U7G0CdC/vLNoPLbaB7Ny3v2aMT9EixC29IoelLQqDRsIvfZI6w/rCJOLhd
         05DLy9J8y5hjI6EHt7sgcMx3zsy47flZTQI1188q5ERsSiX/Wsf30TKiRM789EnbVAOo
         C18cNg78qo4g4GJupJp1f3kZ8mXK70kPfdm9bbyG2kUgonjwpxhaY/XnT5DlRxviH9TW
         MUKjsg2L57/5Sx2ecw/mFGWUBgIUNkBjRMokEL3KRwJxUL0teyeZvBwkMg2bN4VVvsHw
         P/JWLSzi6TlVSPM9SX05b8zzhAk8ea86YBbsvaDrZwOMgiyB7yTk3SNdBnGGvCxR29qC
         SkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748418217; x=1749023017;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EQWlfCjtDnfKxeAaJ1r+er3G/sxFT4dgHxXDNXVy+0=;
        b=becJRMB+bAEP71Vrjg4jnd1Oq6MvYoDBYesZoFYAOBzgPMl0Oh7/KLGoemW1ST78d+
         7ThIW20RJyruCAPFANnrMh1ezmE8DXJw9Ubwm9iaL6e5jln5Pzzo5L5+Gsz1zsv/EjfF
         wtYpMPGVATNHsQXrcWWQS17mhJi0T4saEryJbB80D5e39m2/kqTIMcoYz4QWQngFhAGv
         mIg7q13FIfrXhYAY0DqkYy0U34k+SRUCqykE+uQkSGbKDmvJvXP+25xK5jNmcVFC6e2W
         l5KHm/bIrDMjmGXJ+Wiyu0/OJBP5nrBMnUVApCeNxxgx/2yLKp3meYBzjOzYBLUIDsIW
         yoLA==
X-Forwarded-Encrypted: i=1; AJvYcCXFu231mNfqL1CrWzsjIJFGDey+pHk9857KFzoD6WquA9jWlCacmaEOQAXZt46egexeIEyvVx9USXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF33Lgjgl6k7FLA0FvlNHuPfKu8Oxx5YQn0HSJqhUTIsRiubz9
	+P8Vl5QHSb0vkmRsFUt2ubfWjweI7QeB5aeMdT61lJF1dX1kBDl3XjpBpbcTWvIPNlk=
X-Gm-Gg: ASbGnctno1RuOweApo6Oi3xJLTLOOzaBclaqrPIdkmByuFG6eBpAyG7klJhyCdyXHe/
	X8JxOpuul83cWuhOZWsG6zMOFDDPXr2XDTa5hoQDlEJz7ZVcOMF+Hq95z7awKW6saTZM1+ii3dj
	6neJLWfiavK2D93eV2SDX5JMtGAwoPv4+t4jwkgxEZczu2TCkqxZFCPHmnBc3Lp6EUtrTZdIZWX
	FxIgwAp9wXH23/FVnbKqvQpK4MCBBzamQY3+ZywtkWBHSXr3tfOC//FSjAjDfR3uhLgIUityOa3
	R5qR/etj+uTGom+VxRlbAAOx1QdcmLX3EMrAJh4VOhpbxQ6CJoBu22lIZ85WWPg7OSg=
X-Google-Smtp-Source: AGHT+IHcAGqLdQbuzELTi8NDAjVIRC+cQ4KcI1IKdbeORa87cgvw1HjBGO2TwzgXcMTSoPiTkkq9sg==
X-Received: by 2002:a05:6000:2913:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3a4dfc2bbafmr7119625f8f.26.1748418216668;
        Wed, 28 May 2025 00:43:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4500e1dd630sm12338565e9.34.2025.05.28.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:43:36 -0700 (PDT)
Date: Wed, 28 May 2025 10:43:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 9/11] drivers/spi/spi-pci1xxxx.c:768
 pci1xxxx_spi_probe() warn: missing error code? 'ret'
Message-ID: <202505281417.WyCoNJlC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   6aae49917bd543677e539df17556071edd9a273a
commit: b4608e944177531334a79f3df2cd14275b47808c [9/11] spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts
config: riscv-randconfig-r073-20250528 (https://download.01.org/0day-ci/archive/20250528/202505281417.WyCoNJlC-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505281417.WyCoNJlC-lkp@intel.com/

smatch warnings:
drivers/spi/spi-pci1xxxx.c:768 pci1xxxx_spi_probe() warn: missing error code? 'ret'

vim +/ret +768 drivers/spi/spi-pci1xxxx.c

1cc0cbea7167af5 Tharun Kumar P       2022-10-06  748  		spi_sub_ptr->parent = spi_bus;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  749  		spi_sub_ptr->spi_xfer_in_progress = false;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  750  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  751  		if (!iter) {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  752  			ret = pcim_enable_device(pdev);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  753  			if (ret)
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  754  				return -ENOMEM;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  755  
d981e7b3f25fbab Philipp Stanner      2025-04-17  756  			ret = pcim_request_all_regions(pdev, DRV_NAME);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  757  			if (ret)
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  758  				return -ENOMEM;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  759  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  760  			spi_bus->reg_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
d981e7b3f25fbab Philipp Stanner      2025-04-17  761  			if (!spi_bus->reg_base)
d981e7b3f25fbab Philipp Stanner      2025-04-17  762  				return -EINVAL;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  763  
b4608e944177531 Thangaraj Samynathan 2025-05-27  764  			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt,
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  765  							   PCI_IRQ_ALL_TYPES);
b4608e944177531 Thangaraj Samynathan 2025-05-27  766  			if (num_vector < 0) {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  767  				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
d981e7b3f25fbab Philipp Stanner      2025-04-17 @768  				return ret;

	return num_vector;

1cc0cbea7167af5 Tharun Kumar P       2022-10-06  769  			}
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  770  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  771  			init_completion(&spi_sub_ptr->spi_xfer_done);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  772  			/* Initialize Interrupts - SPI_INT */
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  773  			regval = readl(spi_bus->reg_base +

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


