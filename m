Return-Path: <linux-spi+bounces-8489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5FAD87CA
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C84E3A76C5
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D6291C25;
	Fri, 13 Jun 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL75eAiM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFC272815
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806965; cv=none; b=EJWGsMTNG5nsTj37AzKzrXyyyPdEGIuipFhcUtEQmzBRlEe9D6/E4gEo0/6q4OBrwpDSlQfym5CGwzkkK5liHFReWk7v42cofty4P2C8TNNbaZAW/bQOBIxfip/Q/IqKp8TbUkR0FM7JFfRfHqZBek0jq3G4/FFYdgE0yeNjkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806965; c=relaxed/simple;
	bh=7p1mVSNV29y4bRDyz82Q/GbdEY/tcWDm2Ne86B3G/wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E4kpJ9bF+hGxXP9d2geeamgQKi2DN3a5b1Urie3KzSFqx7ZkX06FB0GMz+/XA77tm0qolFlHNksLY1VSlKZ8aNAyOwehLgYrfk9IWm7YEMQiQl3Hb7/olhWjptrnDWBTfb1wI3b96aAD0nDOUOZs1aqDQzHSc/vhxttzq3Zg1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL75eAiM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1099998f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806962; x=1750411762; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXXFdWVcp6O0/7ql+/EjZalJcJlxIhnM45D+Krf1y+k=;
        b=JL75eAiMZoAAQIv8yjgT0xWzNMSYXjinea7d00EfcKBKtApgjTwbK4Pj4dIJ7UnOm1
         JniHUXJ2zJu6A/BXLu+oOAbGQ15/htiqGfXhISTlmUAKMnmgypcXbJLOGPcHf4xbbBYr
         hYxYnd+9AmR07Qpby8m5IbpvGT4T0n2y8Vyi+W6uN2GP67nx8XEQENS+QSPNmdZBgF/o
         PcxaxHDNv9z7ujWBGB8xdtqR580VywOfCTtLWH20hfF0oPflMpr1t3CKJ7qXeGzk9Z+s
         MRw/smTlc2Q+C9SNPXKWq6Mrd2brwZtKS+TNsrrq1iFBxake8FGt6JxAVRezoz2+6ERO
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806962; x=1750411762;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXXFdWVcp6O0/7ql+/EjZalJcJlxIhnM45D+Krf1y+k=;
        b=DRCXA2KRdm1ItmdZmib6FuP0rWdUAEr3UJQdcyelkCHUDmjOKpDZsx7aafYcA9AMTk
         dr+zxS2jbySkWC/9YaFMUEMFusQ6+eehSV1KVRMYP5TdX2DobvMPtKh2zlD/26cEJmM8
         Mix8/W93BzwS0ITPMbY9Mxzp8k1S0hG19utBR5aJ2Q3KF1aPWw9eqBcRMScJYlGH8bD7
         w1fL9u7AFUlMfLKEh7LCgZhhKk7DiEGfW1Fttk9UOUZBgsP2l+2MLX6oMPgsUn2Y2KUB
         nWiHBw4/pdw1X/8KLEUo+ofJNGyPJtw6gEzwc0gCniydbj6sbaxvGEq6J9mm5Vjd1vbo
         rH6w==
X-Forwarded-Encrypted: i=1; AJvYcCWCwqpX5HAmxMYkbpDv22nPr5elGtqLH1gp0gvYlxB4bwtmr2vI0eOJ07wsG3/lL7aS/4LtYoKFRbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMAGxtOLbVgz9Q0fZbRt+Qd3YyFwW67xgtivCl+OfXSUqQEen
	NHG5TOaB7K80MILxPoqQggFASvTcmjjGDPdMSKdC97EJtSyUeiNir7gSvbqTs75RD4s=
X-Gm-Gg: ASbGncvaRfysRM+u+rpMh9+aRVFVke8h5Ykag198TVgkKyrGvW3HGG1+MLmcdTM90EO
	EjPEP9P+WjhpzLMb1i28xjKqW1SdmQ2Cai9sxHfwH19p8J4KsN9XBaTk4zbfCtE1Gr2axGL77UZ
	0I37Y8YsAH+EGOKTlRbB0z8pmqT0MEM/sXVbgS8pcnzEYLQSsisADDqzf3iUkUUaRGnKgkR9xT4
	tYRD1ialvyHNBZoqcEuHwFu7nTrKUdSLsiuYAd5XYkotlaVdWFcmnhXko2HCeC++vWwrTriCDPV
	C0E1Q8VqUYSiRqoyefTxYrNGYuifU2olDa2mdtkRIRRK6OCIJsURBvuGMD+YGg+6ccVz7hA1lG1
	aiwCSYQ==
X-Google-Smtp-Source: AGHT+IEf7+ii7ddVnHoaRI33MyA3PGEpFJri/RW3ePQZatTIPD6EJ8REtOXCa7Ftpau/vL6emVs8iA==
X-Received: by 2002:a05:6000:310d:b0:3a4:f6bc:d6f1 with SMTP id ffacd0b85a97d-3a56866f804mr2073713f8f.14.1749806961939;
        Fri, 13 Jun 2025 02:29:21 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm1805946f8f.62.2025.06.13.02.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:29:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/5] spi: spi-fsl-dspi: Target mode improvements
Date: Fri, 13 Jun 2025 10:28:55 +0100
Message-Id: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfvS2gC/3WNyw6CMBBFf4V07Zh2kJcr/8OwaGGAMdqS1hAM4
 d8tJCYudHlucs5dRCDPFMQ5WYSniQM7GwEPiWgGbXsCbiMLlJjJDBFu+kEB7DxCGBnahwZdVQU
 ZMp3JjYje6KnjeW9e68gDh6fzr/1iUtv6qZU/apMCCUrmJWFKsunyy52t9u7ofL/VdzWX1T8VT
 ZkqKtTJEH6r9bqubymLa4/uAAAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>, 
 Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
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
James Clark (4):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Store status directly in cur_msg->status
      spi: spi-fsl-dspi: Report FIFO overflows as errors

Larisa Grigore (1):
      spi: spi-fsl-dspi: Increase DMA buffer size

 drivers/spi/spi-fsl-dspi.c | 203 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 144 insertions(+), 59 deletions(-)
---
base-commit: 3adf5ba9ad767e33db2d6aab01bbca396bcb614b
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


