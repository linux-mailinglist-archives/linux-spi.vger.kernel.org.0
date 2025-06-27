Return-Path: <linux-spi+bounces-8798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9803AEB479
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD218827C8
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72A2989B2;
	Fri, 27 Jun 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQ9WX+J2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9C2989B5
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019733; cv=none; b=lGskyRLkQ8Fh2hO/Z9u/PiNiXLmnm9hJr9HCNV+2BmpZK43HJEJQ0gOeUwuH6GKXxm5wmDeQoRO3ovIcRdO3L9rH0x2/BcyVW5TaWHRARTwYb6Ire5Xbtj+WlhlLn5xy7CU0DmJU8Z7lvgyiBHT6Q583jiPSjFhN2pu50m9BTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019733; c=relaxed/simple;
	bh=+eXi3DiHzgQsYWud3YipBZFVOyps3/W6L3tl11/2HAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oL1feKSAuo7vMOP3jTCyZc3f0J6AlaVibYMnmWAz5ujdR/lgiVVKlH9ZDFAWfN8rxNAckR4aTq4ydRok+fpQ2i+/zx7gav7R8eZORLKjrnKYyLlc7m5fGySXrutxJue24db93WT/FSxLOq8YRYYSjuYE2XN6Sic+OqGVRsOa/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQ9WX+J2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so13241095e9.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019730; x=1751624530; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkE+u8fu4iyuqxNowVgVLUi88LeAKltjfpkNJ+TScv8=;
        b=KQ9WX+J2fhUAETYMH6hXPL38admNTxL75bkmV5z8BNBSMXjxad3T2edGnMB9KaFkdB
         ZBMK15m579Xc/koj/rH1V5+2OHGWDdB2EMGzfE0ou7YX3VM37iOmyOJFIj1n55sextrJ
         XiOuBVrfiKh1i4neakS4ux3yGima7ojNzLV4WWkpblbTEc1xkdLb0AuKjm+tY8/ddtpu
         /wW825PE87glu6bFZdj+DWYLoanLfosIDnQizL6onlEfRpTNsaS2YJ1QxtKeN0KUeFPA
         dn9665bGwygez/pHh6vwhRoMUk3dhGkm0wwuXjcMMhsoFsSHsmNd4dNSEiJ/LcPwUMm4
         8GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019730; x=1751624530;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkE+u8fu4iyuqxNowVgVLUi88LeAKltjfpkNJ+TScv8=;
        b=n3jYR4/A5vFAtYiicf+OIZVdQSxDjuwpOVBiSclTvJsMn58wFiQiBqxvzOR8q1wABA
         ags3b5R3gaMrRsAM9rdir7ApKJpxTEtwxdol/Q3e6fe/Tl8B+NinYzdUFWR+bQq31PQO
         VARnf7gditvHNu/5yjnZ3AwooHszEZX0CEScoJRXnazP1/3+LSKmw7MiI6Nd6aMgkDnK
         tk7S8EqAUWKb3+DrlggyejCStss+821+PYHd6pqF2ky3tdXnJ6oPeJ0tKYqs4kPdaZYx
         W3BsN2NqynJrYdu+dgG0N72EjO8rw7aQpDwVevmRX/xIcNj1k5pVh6/HuWvC9dZviVXt
         TH0Q==
X-Gm-Message-State: AOJu0YxvQssx/dJskrYMtoDE4KZvsuntmODk0li9FqDggFW0No1Zz7rx
	nk9ebhPYVEMpOt0Eue6JFnBIqUDztOCfavUtOJKhFp1FAoVH/I8j+WZqQCJQiDB71RM=
X-Gm-Gg: ASbGncu6/Ak4CDONvTRimLaOBVtVyeV5itoXKXWFNkXva7ccqm92LXkvpnCQcjivAQS
	E3nhUNO6dpoAHIqNMIHRz9Kq+wERFDJgYd7GxFHPmhyHb53YvhSosfysHwPq6kP5JXsd+tNRj1U
	yZTlBnAAWqnYikT24+ITtEXd4iKmDBemLm0C1DGzd3jjgb4zp4C3XZfuyLFU4f48rI8KSac39Ma
	Qc9ZcajUFpbiom770+132Jmp3/Go4ahbg9pYjMlh0lrDohLprpGG9a/9VHgLRoFxZr6AAJ9NhdO
	7oz9QlkOguHQPF3GB8kgindxn1cxF4dD1qpw0tid3KpMXGRvYEeiE0gnODvlrqLKtSbZRmE=
X-Google-Smtp-Source: AGHT+IG7QxsvZWl/3ydeZ4Pv3VBNO8dZz1Djzdjybj3GGWSc7o2t+AVTgzQIN9QyIjzq1OREsAK8vw==
X-Received: by 2002:a05:600c:8b52:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-45390699e19mr20404765e9.17.1751019729592;
        Fri, 27 Jun 2025 03:22:09 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Date: Fri, 27 Jun 2025 11:21:36 +0100
Message-Id: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBwXmgC/3XOQQ6CMBAF0KuYrq1pp6UFV97DuGhhqjUKpDUEQ
 7i7hcSIEZd/kv/+DCRi8BjJfjOQgJ2PvqlTkNsNKS+mPiP1VcoEGGQsA6BXc8dI676lsfW0uht
 qikKjReussiT12oDO97N5PKV88fHRhOc80fHp+tbyFa3jlFHOVI4gkJVOHW6+NqHZNeE86XNVs
 eJfFWwuOGouLcKyOn3SwWddcbFGQCIY14ilA2mM/SHEggC5RohEoK4yLV3mFJRfxDiOL2uwYiN
 0AQAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Improve usability of target mode by reporting FIFO errors and increasing
the buffer size when DMA is used. While we're touching DMA stuff also
switch to non-coherent memory, although this is unrelated to target
mode.

The first commit is marked as a fix because it can fix intermittent
issues with existing transfers, rather than the later fixes which
improve larger than FIFO target mode transfers which would have never
worked.

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
James Clark (5):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer
      spi: spi-fsl-dspi: Store status directly in cur_msg->status
      spi: spi-fsl-dspi: Stub out DMA functions
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Report FIFO overflows as errors

Larisa Grigore (1):
      spi: spi-fsl-dspi: Increase DMA buffer size

 drivers/spi/spi-fsl-dspi.c | 233 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 166 insertions(+), 67 deletions(-)
---
base-commit: 4f326fa6236787ca516ea6eab8e5e9dc5c236f03
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


