Return-Path: <linux-spi+bounces-4361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFDB962F25
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 20:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62921B21E32
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555F1A707C;
	Wed, 28 Aug 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfQAjEe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4D14EC47;
	Wed, 28 Aug 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868081; cv=none; b=hpamCz1fPhAgdv4gnj18gWqeX7sc6XCW5uZVGVv/E+IGKRPHGhuo+xtuDfKtMtpdSk10vI90ovqZ9yDGDSUtjnCDGoUCTRzBiArTLSI+vZrp3dgG64mfw/VH1sR/8fdAaZWZhDqOrFYr2Cvn57H5veMej2qzg9CRattnAVTXzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868081; c=relaxed/simple;
	bh=55ewzjg2qor17cvpizwQMAMM8U7C/CLO4AOa83TqZ54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpUydHHgTyNA6nlL8cAuNqNay6xFJhJIdQjOKo4vKkK6EqLjLbr4dt66Tp0Z5PeUvlaYJgVNU00BR5rcJkgvFjArkBtN5o5VtsIc17fGaVSIp76UzgRngS5t8WcKmUlkbi1fJ/PNXNkVs+pFxG/I/OaWWGg95zVdtMMbg+n1R70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfQAjEe; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cdf2ac6130so2047144a12.2;
        Wed, 28 Aug 2024 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868080; x=1725472880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8nfjGtrBJwHu3jsvem3hCgMv99uk5+gdx+bi4jO06k=;
        b=mNfQAjEej9nJXpDkaF9oYAPxOAj+naHRzFboFNd6edTxXfsAITfMb+cTjbd+r+aQsP
         1N9DfFHFX7uvULTTFXZdc0YFcUA1D22r5Ajf7E3CGXtL8lpWqvjf73a3IDhjeiWalgwc
         2qmC72jePN+Ce8xtxtiiVj+VLfWqafRD63sz1Jve81JkXLgBd2Vcpu+EgJ35NP54ZAOt
         KaS8tC/XDqA3CxN0cSTkkCF716nD5xIwrIZfRU32Dr2H29KUVH2uDLYQEaKCxorqb2dO
         tEnOPlziopwiyDyc4oVl1Lwmv3XzBgg3xKjxaEmn3dOeWhJEYL+IyTPdg+6AhnXegM0m
         6eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868080; x=1725472880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8nfjGtrBJwHu3jsvem3hCgMv99uk5+gdx+bi4jO06k=;
        b=EB9qzV6DttVKUNHYpxIVg5SMr8EIK/s5RbCdZSpGTF0F++2jPpPdbT7+fYGFoGcVi1
         ngXmjjxv23r84yxOlQtZRA+2vZL/HpUiSDn6Z9Q21iMOrnuryxufLN5zLs4fdJ2i6fQh
         LRJEK1IMs8NhbWlDo/utT37xf1Xmz/2YKHcd9zYrDpmuYvQITyQTXFu2XoyOkEBzrIRg
         xj+iwgfnJDFwB0v/Se6yskl3nBbOiNTfVXIP3nOvMPHcJ0jhqXK/fN7FYwBoxM6rXQGe
         AQ7qJte787SUNy1jhrBtjhHtrrcP9vxxYl4V5M0DtdvSKUzDnw9ZgRauzpZyS6AcaMIF
         zlpw==
X-Forwarded-Encrypted: i=1; AJvYcCUSWoPkcw8Mw2ySg8SwYqJ7NrWTqNJA7tikcI3T/rTiB1b+QL7h5B5I7u94OA6NsL8i5XSgUPfRrWBf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iNutxbPZDqV+23lPCITry8IOcHwfvS+RZm4dfTjf1Vn1jDwb
	7GHgDEpTBBLNQ1V20as8blQueq5ZzWmK8/2w6XwD/BxAUCBOQ/9JNRhLeQ==
X-Google-Smtp-Source: AGHT+IEEJzUUdbcXwJ7R5Mkxwt0b9jh5z3waWc0+wtlwZ9XW/5kNyRevDhCZ7dM/H2L9bnuBIeKc8w==
X-Received: by 2002:a05:6a21:4d8a:b0:1c4:d540:46c with SMTP id adf61e73a8af0-1cce110811dmr98448637.47.1724868079604;
        Wed, 28 Aug 2024 11:01:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143434294asm10300127b3a.216.2024.08.28.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:01:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH RESEND v3 2/3] spi: spidev: Add an entry for elgin,jg10309-01
Date: Wed, 28 Aug 2024 15:00:56 -0300
Message-Id: <20240828180057.3167190-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828180057.3167190-1-festevam@gmail.com>
References: <20240828180057.3167190-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changes since v1:
- Use a more specific compatible string. (Conor)

 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 05e6d007f9a7..316ed3664cb2 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -730,6 +730,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.34.1


