Return-Path: <linux-spi+bounces-3560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83283915795
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 22:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B186E1C21EE4
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6938DE4;
	Mon, 24 Jun 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fkzpX3pd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FD1A01DD
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259850; cv=none; b=iH3n6ywXtI1Wur/uB/2JZu0aywLTpfdBTdIPdXys+GYTsqnQD6JXmTUHA4AWBjyBSV2etOV27fp4FJTGXo2j+KRC+7f+7SKKTuvP3ue+Penw916DFGsxYJgtIA1dKWJ/VcB3K7rG5SFm5UnmDi1fWQfEyRLGNkwos6OuCGmijYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259850; c=relaxed/simple;
	bh=gwveKsBVtN7JFtmU94y848i/o5pT/Jhq2LKbTqkccp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODA/cNaNzYG5Eg7XmEStQHzXRnx0X+JgQ1R2JWUMCCmf8tBSeDwJR8v+C1yqJhNvL8sLATOhCR2NPXdV1InFM9QrE1AzeFX8+ifou+K3M91F3EF3kKB4AADWabCqsmW9mljztisAOe46C2vuPBkneL2t09KSKB3MSxAxbb6V20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fkzpX3pd; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25cba5eea69so2301980fac.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719259848; x=1719864648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pynIwSYLtFCFqE/LQh0xYvfYgPBDJkazLg5naxF4gSA=;
        b=fkzpX3pdQsNMGXaaXbgrCM8rgVlEgWID9r2Jw7nTTqnKu3J4VtKfnXp+CRGTMijmvN
         xt+KtfzfapDKixaeOzyaZBxbPARuoxrdtVpjPkj2ED1I6U5iaaoWF6LlFP06XotfCEhp
         b26CvwuJ9XHtbBQMlAAKK3PtQbdg4/wt+ZTOr0m5wN6eP7jM8uBEsZ7bB6pV7A8qptCc
         d/5U5wTN9GRifeOzHQOnk5a3d3r+4WrwT1PyKHZFG95l27UbXhHqsfctbWTrz4g7beCR
         PYJt8w0Fn2WxUeLQ0bhYyZRK3WZB+21FxMAGTUzS6DLT7eKDo3sx4iuLVAU5CEmhNdSq
         FbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719259848; x=1719864648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pynIwSYLtFCFqE/LQh0xYvfYgPBDJkazLg5naxF4gSA=;
        b=WaPMjxFJnlMWKeb53jhsHmM3i3KNk6bsUyz7+9rNWBIG/p5are1WGRLHH036iVSP7w
         claxr8yOsBtPw5EIstX7pkYgtNeRlRXNORhz4fcQSPOxF/oVTMNtf/ryNrAYD0sJthZM
         U2tTsyVi6w504J+gPUh8kZXeCL9q2G3caJLvQAts03eK5McsZFGNu1Uvm0Ymr0pjkd3f
         lcFK64kFzBzRoF4viEQFvfexLPNHbwbonl6Sp/jX7hpaEuL8AU7GL0hbDxRDa5/hy0K4
         fN331c4FXSVLnULi17b4FqUC525iPEsjxXprBuomi2o/DkKUqRCytJpAGwdLw2XnXUdY
         5raw==
X-Forwarded-Encrypted: i=1; AJvYcCWsuvzhXAWBvEBMq2zEhomGpCJJsDwaiO1nPwNa3JF4DRVcTHhFNibc3nHBszAyjOIJORDRvNRvqMs60+0DoF0Hod5V0NiMfTnU
X-Gm-Message-State: AOJu0YzmGnz0iCm8AahP3UJ1z8e4krA+YrwQZdWoZgY41QD0H2wZEYtZ
	yqL2zr2ex7w36PyfVBT0aMvCDSNw+XdovdqtKWs03VrdWsFi6L/M/vK3sHDAKp4=
X-Google-Smtp-Source: AGHT+IHRPUfp+ZBPyKVGnp8PYVSyxPlPBcZpQHC+Oj3KSMk2tSXxZxcaP2yg1g1kDGwwn06PCl+SEA==
X-Received: by 2002:a05:6870:40c8:b0:250:7a8d:1756 with SMTP id 586e51a60fabf-25d0163e8d0mr6380388fac.12.1719259848112;
        Mon, 24 Jun 2024 13:10:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd498872csm2056581fac.21.2024.06.24.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:10:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Date: Mon, 24 Jun 2024 15:10:30 -0500
Message-ID: <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
References: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

devm_spi_optimize_message() is a public function and needs
EXPORT_SYMBOL_GPL.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20240624204424.6a91a5e4@jic23-huawei/
Fixes: 17436001a6bc ("spi: add devm_spi_optimize_message() helper")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f953504244b..814d66fc9753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4384,6 +4384,7 @@ int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
 
 	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
 }
+EXPORT_SYMBOL_GPL(devm_spi_optimize_message);
 
 /**
  * spi_async - asynchronous SPI transfer

-- 
2.45.2


