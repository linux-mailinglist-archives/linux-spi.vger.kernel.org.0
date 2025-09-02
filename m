Return-Path: <linux-spi+bounces-9857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D93B40140
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4297A6F8D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E62D4812;
	Tue,  2 Sep 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RziTgXK7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EB17A306
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817171; cv=none; b=EjV0Zvrbc92b0DkoTKo5KKKu/3wo+LvDN3zszbxTTLmK3X+lXzGZ3CGCnbyOdNuittaOWoYVkEr9hCS71YKmml704XZtIdycdXb/U9hA5ZB9G5/sjnASlQqz5SfcLrd3eGVp19T4siJhQEnPqLCbi54X2ThySu57CZSCHbc21hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817171; c=relaxed/simple;
	bh=POJObNFh7AVhgNTruVq+Xi5sLajVg1vzZFxS5kzJHC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z/2pllCzLJCGO2HFz77EfNjCpncpzHfBtW2TPt+Oqy8VsaUkmdQLjg9HNeN8FFfFPjWHz5mL5q8lNomemlKLXISulYiLphW5XKSHLAfOTsAqEMoQVo7hEdQ7MNse8sY5/aKX1nyn4G2evug2J0uN102ZCweulkk5y1ff54RpdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RziTgXK7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3387202f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Sep 2025 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817166; x=1757421966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkz/GzVRYoiCISZtLFw3scA7aE12YSWSrXnltzuGjsE=;
        b=RziTgXK7T/LBH7HWRXnh6hho16rFwouF+ERmmDFC4ZcETMSIo1iogebohzI+gRTm4T
         gIwCT26x0eiw3kPdB2rc9rZvDxcxqWZHl91pWbDjfHnEgW8XXxgQ4g4xy6BIF5wKuw0e
         qbitZQICXoIetdcr2os0gGzX68NOYAlvJojV6GFcGnJTApwsDe6p011giCYDJXySvd9g
         8TTxFJm785OsYOjt3Mi1pCgQUgn/x/Uz+4Nel731P5AJqa0qYXcAijIFiQIiW1xE4DnE
         /CgrslOy7jc11nxEKaXVVXPSeYFASrG7Rs6ydlvJFMzhZhQdEnzf7vOEB1PZT/PZrem4
         vR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817166; x=1757421966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkz/GzVRYoiCISZtLFw3scA7aE12YSWSrXnltzuGjsE=;
        b=eozZZ8bovN1Ux5mjT6bMtiQY+rfbBpvKYp9ss6Q7lHnHkjoW7lDPCU524VUVCVEvjr
         pFN8L1fAYsWTd5zbsQGz/0W4+BVF/po9IjS3oe48nh07VvdFy1WX4JTYbNBy/7yMJIQU
         PSzwjmbw0tfGtIqV52s6FKlikWlFwV7PRfQG4kYKbH9JzvK+NPBuLvEd/sjhzJ8xBBt+
         qhXUmTMdEj2C3GIUf60OwVeCVIsdrWu8y/CuFV2y2esjqjetDHuwBFkLVWuNEjmRNiWL
         IBaC2GVhZhjPoSrzoTMLdZFel1LilevQlJO/3sf/Ef7Tgz5hNeTdIY/fdVrlZ2ebGsWC
         5a3Q==
X-Gm-Message-State: AOJu0YyeLZ5nfActupN2fvMD+/+wpBVyTpbIU83a4jVWENWKSYGr9IMP
	MXOkA+2dEz/dM5PUfReUzbGKH3RXgP7zjad0NYPhl5r/kaxMZzi40uKhPZ6yRUo20JU=
X-Gm-Gg: ASbGnctlwvzRz+jVWayAYxdCu8LQx/99gd6CWM0Frrd6G4/vDVbyqVtt5ma2MziqihW
	NW5fhBwUi6Y9fCS3GwVttRfzKTOnGoxxaIihog9QJyEAnN7Rs7SOMnNwI2zTB5ziuJ/iDufdhTL
	TlSdURt+GhdqPRKLSOEBT4H1Lr+77Zp54CywBD18G9kuqEVJ70xovkWZnhUthpajuYubEsmU3RE
	PGMuoM2A0hWcMnI8gQCWwKI69UnXvoqRBcD4Agzd1RFOqZVCEIhYGVhy8GBWaNXKgn63WYtTMQz
	ELkJi3HfFJfDMk5h2HwGxv/oX0MISBfIHO8l34jLJMoBOZZQ6lQMxSbNhojf79FUkZJTXqdG9kK
	7vdBwN+zz+DC647jGrUzAwU8JNJYT6ZhXJn7LLV7/hA==
X-Google-Smtp-Source: AGHT+IFbaVWYXWBR1Cmns9iojh+9vfIJYMcqyLcen3CRJyhHB0CL5CDu1EmE0O0yWjMqeK7PEOyKpg==
X-Received: by 2002:a5d:5f4b:0:b0:3ce:663a:c92d with SMTP id ffacd0b85a97d-3d1df53baf5mr8258978f8f.56.1756817166199;
        Tue, 02 Sep 2025 05:46:06 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:05 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v6 0/7] spi: spi-fsl-dspi: Target mode improvements
Date: Tue, 02 Sep 2025 13:44:52 +0100
Message-Id: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXmtmgC/3XQTWrDMBAF4KsErasijX7dVe9RupDkUaLS2EYqJ
 iX47pUNJS5Wl2/gfTPMnRTMCQt5Od1JxjmVNA416KcTCRc3nJGmvmYCDBRTAPTDXbHQ4TbRMiX
 aXx11XWfQo49ee1J7U8aYbpv59l7zJZWvMX9vK2a+Tn8129BmThnlTFsEgSxE/fqZBpfH5zGfV
 32ratb9VwVvBUfDpUfYV9dLZnhs11y0CKgE4wYxRJDO+QMhdgTIFiEqgaZXRkYVNYQDIfeEaRF
 y/YGxvXfAAgd2INSDsND8haqEAKk7ZZxG1/0hlmX5Ab2BQsH6AQAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.0

Improve usability of target mode by reporting FIFO errors and increasing
the buffer size when DMA is used. While we're touching DMA stuff also
switch to non-coherent memory, although this is unrelated to target
mode.

With the combination of the commit to increase the DMA buffer size and
the commit to use non-coherent memory, the host mode performance figures
are as follows on S32G3:

  # spidev_test --device /dev/spidev1.0 --bpw 8 --size <test_size> --cpha --iter 10000000 --speed 10000000

  Coherent (4096 byte transfers): 6534 kbps
  Non-coherent:                   7347 kbps

  Coherent (16 byte transfers):    447 kbps
  Non-coherent:                    448 kbps

Just for comparison running the same test in XSPI mode:

  4096 byte transfers:            2143 kbps
  16 byte transfers:               637 kbps

These tests required hacking S32G3 to use DMA in host mode, although
the figures should be representative of target mode too where DMA is
used. And the other devices that use DMA in host mode should see similar
improvements.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v6:
- Indentation fix
- Fix trailers in first commit
- Explain reasoning for "spi: spi-fsl-dspi: Stub out DMA functions"
- Link to v5: https://lore.kernel.org/r/20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org

Changes in v5:
- Change some ints to size_t for consistency
- Separate change for making buffer size a page and making target mode
  buffer larger
- Explain reasoning for target mode buffer size change in commit message
- Replace an if with a min()
- Drop applied fixes: commit
- Take Vladimir's change to separate -EINPROGRESS and cur_msg->status
  changes and fix the bug
- Get max segment size from dmaengine rather than hardcoding it and
  store the size in struct fsl_dspi_dma
- Link to v4: https://lore.kernel.org/r/20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org

Changes in v4:
- Fix !CONFIG_DMA_ENGINE build (and actually test it this time)
- Reword completion counter comment
- Reword some commit messages
- Reset tries in dspi_poll() for each transfer
- Check for fifo errors in dspi_poll() before checking for completion
- Link to v3: https://lore.kernel.org/r/20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org

Changes in v3:
- Stub out DMA functions in the driver so no-DMA builds work
- Link to v2: https://lore.kernel.org/r/20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org

Changes in v2:
- Store status in cur_msg->status rather than adding xfer_status
- Show exact underflow/overflow flags in error message
- Rate limit error messages
- Add a comment about resetting the completion counter prior to transfer
- Rename dspi_is_fifo_overflow() -> dspi_fifo_error()
- Add performance figures to cover letter
- Rebase onto https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/for-next
  to avoid some conflicts
- Link to v1: https://lore.kernel.org/r/20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org

---
James Clark (7):
      spi: fsl-dspi: Avoid using -EINPROGRESS error code
      spi: fsl-dspi: Store status directly in cur_msg->status
      spi: spi-fsl-dspi: Stub out DMA functions
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Use whole page for DMA buffers
      spi: spi-fsl-dspi: Increase target mode DMA buffer size
      spi: spi-fsl-dspi: Report FIFO overflows as errors

 drivers/spi/spi-fsl-dspi.c | 232 +++++++++++++++++++++++++++++++--------------
 1 file changed, 162 insertions(+), 70 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


