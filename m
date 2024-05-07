Return-Path: <linux-spi+bounces-2761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F398BE5AC
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8531E1C22BA5
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0816FF3B;
	Tue,  7 May 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl0t8Kfz"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0016F906
	for <linux-spi@vger.kernel.org>; Tue,  7 May 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091300; cv=none; b=NbhtHk/rcNh95jVwbEiqRfX5ouCLzk+GPG+aFE9ypm81mFTT46082P0VgTa7NdsNLQSeZim/fwfovD0JD8/NzUvKzpffh+o0t5l42OULkkXtJKmL7nudUlHwwrMz1eip79cgx/NOzih5upoufkyjx1F5YZeTvy6BdWiVdRHvDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091300; c=relaxed/simple;
	bh=tYFhuNKK572ei44KClvdIFHmT5dQxptc6wlidmEeIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tVrSWCH5m4Vxm9WZnre/1NydZYUBirAjLgQIbOX6UB6TnYKTfmzTmYilqwuccUvhte85F13BL3nXTjuVAjYGBrdozft4DWrctiexbSplVxUWAPnY8BJK7IEfV3J3cPyd+Jm/VESKFt7ipcwBMI3KdBLvzU9UAI2H5vre9fut4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yl0t8Kfz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715091297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1TemjxCew8gfx5TJGpneLG70M3weE+hrm8/BhqnHVY=;
	b=Yl0t8Kfzr7karWVMm2VQbtLjaziU8gRvHwjvM1EZGwDOSQCqHFVe/O9+VQ/lZ8Ea+udXJx
	XGOwJbSAxmhjUY9+bnvWs3ZDckbdsqiudlTpVKu5ZEDbNklRjRCldYexjc+L8tub3AjK3F
	66WVENfyb+5FIzDr+s4ykcEkEc056do=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-WnMi3dCmOAWWMEo0Ocym-A-1; Tue, 07 May 2024 10:14:56 -0400
X-MC-Unique: WnMi3dCmOAWWMEo0Ocym-A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51f0d924685so3106866e87.0
        for <linux-spi@vger.kernel.org>; Tue, 07 May 2024 07:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091294; x=1715696094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1TemjxCew8gfx5TJGpneLG70M3weE+hrm8/BhqnHVY=;
        b=JwllE1S47VAorrXG97Jc3ccY5XjddfD46+Rf5B6T//jzF8c1AsqI63ATFvChdA0Xd8
         muVLn7CI3t4IOpS+j+hpaQtHbHZXpcxiqaJLgzGQWABgWf6Ehk9khQgIBM4v9fX+4Dy/
         NHYh/uwr53MF4iT5byecfU5WR8NtI6Iq4ZwVpqDgTptjD0nZJ3FKuiNB4CUzcCHLUnKr
         y1scIFsT9rRsj9s9kDrKVI5N4TALDgAVDot4kZ7H+XKAuzan7HnPzW4mBjaSOsL8qu52
         HLVUCSsb3JsPFVIp8i4eMprfQNpyHjM2gWp9MRAKwjfY8/5hw+4u+EdoJ0Du6t061RyL
         T/kg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+KUcFUXyc4BzfdpFH07hxb6/By0JLEsWlLlxF94BJN8X0Rjn4sEe8iL/WeRUdTLQW7huQF4y626fOXIPJUxVea2jnfpqmtBa
X-Gm-Message-State: AOJu0YzCiNz0QH8P1CZe4kdgswnXHtDec0Q9xVgvDjF5/gESj1OqesWZ
	C778JQxplrHF8Nf5mjOdS7mU5KKA0yfBeL/T9Pz4ymWu1c35bBrxb4QUfSMdYRw1+weZjfWKHj6
	T09K0j9mEtS68NgpNxOxTXmcAbUkeNEBDDha4knORpcSmTlMgmczh3DgkMHZwMskczw==
X-Received: by 2002:a05:6512:78d:b0:51d:1c56:b0f1 with SMTP id x13-20020a056512078d00b0051d1c56b0f1mr9151815lfr.17.1715091293929;
        Tue, 07 May 2024 07:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL6gtJQR2L/AKZnQJ9Vjdq0OBoXAmgXMJxKgRmEQ2ocaAFqN0lJ69a1Qg3oAiWGUjW/dsk3Q==
X-Received: by 2002:a05:6512:78d:b0:51d:1c56:b0f1 with SMTP id x13-20020a056512078d00b0051d1c56b0f1mr9151789lfr.17.1715091293449;
        Tue, 07 May 2024 07:14:53 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906169a00b00a59a09e34adsm4681491ejd.195.2024.05.07.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:52 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER
Date: Tue,  7 May 2024 16:14:49 +0200
Message-ID: <20240507141449.177538-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
adds a new section AIROHA SPI SNFI DRIVER referring to the file
spi-airoha.c. The commit however adds the file spi-airoha-snfi.c.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry in the AIROHA SPI SNFI DRIVER section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca79616a4836..2fe4506f9fe8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,7 +689,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
-F:	drivers/spi/spi-airoha.c
+F:	drivers/spi/spi-airoha-snfi.c
 
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
-- 
2.44.0


