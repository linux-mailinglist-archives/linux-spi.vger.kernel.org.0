Return-Path: <linux-spi+bounces-8370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712EACFEB1
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20B93A1DF6
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC736286409;
	Fri,  6 Jun 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLBdE6Ky"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF91FECDD
	for <linux-spi@vger.kernel.org>; Fri,  6 Jun 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200663; cv=none; b=hSu8guOQ4MAVlrHrF++S8EhbOElYCmajVHTsGmqKjTFw77xT9UC/7ZZaegS319TDjPfVzLLc2Y/QMHtDEBxhm3QHy+ZkGnPvlDWVN29Qkc07vud9gOi78wngK6SPC3pgTztqtsCcNad9r/XxEl2m6RAf1za3eFKg4dPwD5Va3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200663; c=relaxed/simple;
	bh=atA00FElL1PdAn8QEx0N6GgZX//dcCoPP67oO9WxXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G7Hu3jN1wU19Gh1i0luXUSneeGhUMShpO3LNoyOtFlzx1jxQHSu7QdbNVnbQbD1bOJjrWzJoM0ybn5rXNtohWPwvZM+VTpAdo0lF1PJdnxaubaWaGZoK8Getbvtyu5s4Tdjxs4rAKWYc+WVueegtPg+q6V7UwfiL9EBE3nMwnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLBdE6Ky; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cf214200so16754985e9.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Jun 2025 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749200660; x=1749805460; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+0n8NKWl3riyF7/7I5pRPKqW7VrVfcXJo61+Gw+kIg=;
        b=FLBdE6KyuWCOEJ6DiXopQgcFNtVLB0ly443e90Gh7P+zYuFY6tBGjir/iwBQc8CkOY
         62oNPoizn4tGbJn/app7aq2Ai2NEuqSQJMFK6rSJ7mFBSfeMXgKylT3g+Zu9JtpQmW1w
         /kUSJn3rAHmgmOqKshbeGuBdib1jBT09PqLx69EMYj448NQqfdI00M12OlVw7d9HWOjV
         z1/tdYqUi8/EkpvwvDiL7uQukUTL/1LFlLLr2EAM51MPm0VZZjJN0aZedogcXjXm+d2L
         k7rSfokygEUPo7ff5ziU+EsHh25FeAnw2lGQr3t3Sa8CCVFb/bOJ11/MbXRcVmMNnhvN
         Kq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200660; x=1749805460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+0n8NKWl3riyF7/7I5pRPKqW7VrVfcXJo61+Gw+kIg=;
        b=UJ6vBkYcM6RC1W8oefdnzZeaiaNdswaKD4Q5zuJnXzI+ca93eeJDvqt9ahBOpdzu91
         GMPaDTCMkQVfYFqKqfJBhHDQMLjbHdImdKilRJQ8yONRwxbzab34rzItKVhpJrDpIyl6
         MQ4VkZ+MDnJ0IkdcSngD0KRET9ITNHO97RorDRbRC0DOI0ejWNltl3exiIWWSLxZThaU
         atrIYQrK6vGtGNAlpyV5UkXAUOIXreYXXcfj1r1hIHNkFhMmLTNn6fMOVMLG9OPY1Y+K
         cLMELBC7OK1nd3vS0pTebeifFl3Gd8QUo80bFzTUzNsFr+vq34OA0q9WV8XWPZyaNMpI
         Nb+g==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZezS0iEahawkyycO0J5gLSLecAuW7s3EsqOO28Xt2xWkU0F+/YuI+qxV6CxK8mqwGyScOZefvFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6zxTT3twMKhtU1sS9oMN4CXbLhXgUeZ4otAUx3Q0X8YbO5IY
	QEfQZuS10WbWWwul8pAvbi546+4z2VcZhxsdQe0ZGuU4OB8yTCykBRxbNLQCbhkItQbmeagooOC
	PeM2u
X-Gm-Gg: ASbGncsCQPIKwtb2eRDydxWnaR5xodGnVH0JlPpuKthdx8uSJwLo/IDoGAtVU3VrLfL
	w74XsFJkgtem1JfbRicYCs+m/yYVcJ6Of8quMwrD4UhprpGOSug51+0mdqbs9gmVV/w71JnhZML
	k/fCKRFKMd+EjSIUv03YDuSBe9W9ik5Otez3Z+Rv9H9kYP3Jqx30MyhWvuGLme0XSxKeJRvWeRe
	K2P7ft4qGORvLeShABH3rPgAu0qfNP83ALx0W5zKX1Kv9r88Yg39gRtAwZKoIsjix9WASGgMZOI
	FwXw7+MCumvzVrKQLB4dHKm+SPY3t0j6eK7DzPXL45l2l9sBDL7BJqYzsQx87bqAOVY=
X-Google-Smtp-Source: AGHT+IEMgnQm6IyXJETnU1joAUlaC9jQwH6ZYJk+ZFID2NbYjHHTWiY2iKL9SlP/kooNnTgG9NsR4A==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-4520147f41emr28594825e9.18.1749200659602;
        Fri, 06 Jun 2025 02:04:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4526e158428sm14173225e9.14.2025.06.06.02.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:04:18 -0700 (PDT)
Date: Fri, 6 Jun 2025 12:04:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: spi-pci1xxxx: Fix error code in probe
Message-ID: <aEKvDrUxD19GWi0u@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return the error code if pci_alloc_irq_vectors() fails.  Don't return
success.

Fixes: b4608e944177 ("spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index c6489e90b8b9..9112d8a1a0c8 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -765,7 +765,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 							   PCI_IRQ_ALL_TYPES);
 			if (num_vector < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
-				return ret;
+				return num_vector;
 			}
 
 			init_completion(&spi_sub_ptr->spi_xfer_done);
-- 
2.47.2


