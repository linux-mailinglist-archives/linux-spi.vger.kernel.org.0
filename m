Return-Path: <linux-spi+bounces-9768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3800B3BA24
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A18E1CC08D1
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CF2D640D;
	Fri, 29 Aug 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnWSoTl5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A52192E3
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468046; cv=none; b=mzCw8rq6SzTMfkEIoWiavkJcQXH2qaWVc/xpK2CTebr/BiYglowJY70U6u+BHkE7EHAtys27QxqcaJUgXx+PE2KskIzScy0EKxvk9LUkvLSaiMBblldDr3+Z9B9kGlUB4RXqVukLO1nlxVgzJ7w+YaUj0t43haEyS3JoFWJB69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468046; c=relaxed/simple;
	bh=nH+7SyLbGXXqvFgRv8pQOol512xjM5XrGIqVoZmP1xI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gma1htlXeb49CrfeAGOfpG1/QYIg4kcT9Y61pNLXQ4tO2+nACe+LUVWtCheTKkNZlyddIdYy52fN2fKofZRhg7oRTNCaSaDtOsC8i8gZ6mquv+1Icha8ejhWAkM90apv6BPr7aDohEscbBaV/YUinNfNVTV/ZRD84OTSyxgWfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnWSoTl5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso11615655e9.1
        for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468043; x=1757072843; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/IvhXAlhsi61CJEzF6AyA/gZBXATfTlkMgbkVbOHU=;
        b=HnWSoTl5WdVa3ZoIHD+XeOZpjtMn0j2oP3N7l3tuQLsZcL4IkEGGRs+mNI6ufQH7E4
         pED5wW73flVI9gcFhf3HAqnnIruFxJI3N6ezPUY8YT1bUp+Rqwsf+2qA8NpPy4KvRt8H
         NfZ+KaduWZjrsb1/Sz6BGBNtANIHhtuXuezMZJlgroOMBaeYB/OlD5lB02eRPYhYanUW
         iAidsrK2g4GRWtR1n8fDTus3XGNPc1j4UJ3jTUiu5+/x/aaMIVbzH0RadT1GgOetnQeg
         dh+uzAy6GSFHsnRTPEDMq9N5krsNaioFsZGpO9UQCNst5CWd1yiRkvkFk6Hm9MxcTnvZ
         P3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468043; x=1757072843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX/IvhXAlhsi61CJEzF6AyA/gZBXATfTlkMgbkVbOHU=;
        b=QuVxAcgj3SsIKdNmYHwD5ssPTVb8Xd0N+zh36XMd/R69ux92nuxRN48xwr3rLdDQHE
         85wK7NuI2R7syZr9PWV3g+savYPc6JvoV7TarHP9lfgFTeCGjMpZp9qGiQZ+elSEkjd9
         LrjiqhUCd+XtpCoAEpciWnjAUiHZy0OvXWIs779Sn+fJtfyZBfMMQ8+HnNzlvM0QnC6g
         c1TSyozZ1X5RI6ECDAKNHF/hybXSaYqJ+awLBi7NU1T/21z/gpVGqIjU9n2hfMqs6Go0
         JYWgkTu4whhyXXwimHNmfGak9f6Wzkwb9rnIydOJXahm5Wzdn/Bxf+YNLYHPQirqpPiZ
         FZag==
X-Gm-Message-State: AOJu0YwLI5snemAMO8kdTeGz0JgwaZtPW+6ZIaqYj453pr50Yv7MFfa/
	6Vu8MnPS1fT3gwF3JXgJLn5WTSeZI2fHGJFpae6ItSIdivKeF5XbY1RYdEMzn8DUZOs=
X-Gm-Gg: ASbGncvPtRROSIioKO7xXzi4CVb9NOwGPwNlI+FiP0tk77tE+6Rb/ort4GNZCb48zk4
	yUeNoDIGSLD/iYDLn2mF5Gx251M/wGFuzi9KK7xkcszLy2/7gysp1n+DUb0Lr3FlAcUxG6Oo5uR
	W/KR1kreXG2FGESAT084OEAJ9aFXbKjHF1J6iHK5d+FduD0/daSyUa1HXPkWvHdUIcS+j/sA1K3
	v5cCax/D5slkQja64lx7WKh4EggK72XSolnRJnOK7n4oi2OdXbp463vWfoo5uTX14IoBTqHvEYx
	2svL5MDTT8zzfj9VbL6ykAok29wZxppZIwE/zRB4qjqGzxHVTa9nhnZeXSaNKe1c1mHEXsrLn1R
	bfQuZIzXtTm0/onl+ZpjCEuldnrn0Xa4=
X-Google-Smtp-Source: AGHT+IE6sYUh8BxMIMLLQlY8sdD0DAtWz+61SjvndENSWhM+VWl24xZTFdLXTJzV2n7T/jA/aN+mnw==
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr252723875e9.18.1756468042770;
        Fri, 29 Aug 2025 04:47:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 0/7] spi: spi-fsl-dspi: Target mode improvements
Date: Fri, 29 Aug 2025 12:46:42 +0100
Message-Id: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKTsWgC/3XQTWrDMBAF4KsErasyGv3ZWfUeIQtJHiUqjW2kY
 lKC717ZUOoSd/kG3jfDPFihnKiw4+HBMk2ppKGvQb8cWLi6/kI8dTUzBNSgEfm7u1Hh/X3kZUy
 8uznu2taSJx+98az2xkwx3VfzdK75msrnkL/WFZNYpj9as6NNggMXYBpCSRCieftIvcvD65Avi
 75WDbT/VdE3UpAVyhNuq8slE/5uN0LuEVgJEJYoRFTO+SdCbghUe4SsBNlOWxV1NBieCLUl7B6
 hlh/YpvMOIQiEP8Q8z98GczmFtwEAAA==
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

 drivers/spi/spi-fsl-dspi.c | 222 +++++++++++++++++++++++++++++++--------------
 1 file changed, 156 insertions(+), 66 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


