Return-Path: <linux-spi+bounces-10787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8556CC02D06
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 19:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00124E1114
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98434AB11;
	Thu, 23 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="RDd69FSh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD134B1A6
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242369; cv=none; b=UMB/gcB6W0KlovObAtUmLT/8VI5Dq15EgByUu/vXFIbpo8rceIwuUKWV+U4XzslZK52LRUJApwS3r4YrXatSbLGJJm63HBnAqQNgFHwpZ1x/cDyFQh6VI6G3UxyMRjpqrJURY60/cNlpeiKc2ij6GSLlPVtMrWZL8TsEiOQu8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242369; c=relaxed/simple;
	bh=a/X1Acv0a0Io7YPwnyOgCxxAkklMU8dT+67o6Oa6kn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXp04jpNYslolw05J1vMAeNEQbGkrtfotYfgGW1kG9bXIRWkuPDQwqFT2qppn59BlSwiRFffn/NOy++P7rVQW4ES4pa9Sdc67Z7k74QFzdiEszxMULxeZwdKHvggq78vVOwUUzKiW3mSRKtgEjk1NdYAjb1RX+JSwAVTgYmtO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=RDd69FSh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781010ff051so791226b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242367; x=1761847167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfBpxcQetznup7hF07KUJDBVrurA0aaR62AdWj47guE=;
        b=RDd69FSh4HYck4WE9ZLnqBevWz9FwNRjAk6eh71USfTzfXGiyLz0Q9onBpU3W103tV
         BlV6pp424JLmMkoQhtYF74nEKvoTv+ZDMJd4BZY57Xs1Fzko32nxn7xBSxYPVKfP82+R
         n/boSC07SjkJw0pKxAUbBObGoijhaxYP1X+CBf3ZuyIjP0dqaKISLviIVouO0CrMfGcC
         kKZOr0VxYFT7S6/Z8fLt6uyzQJNOSlLkTB28kQuWAuxqHihCSKLShTsHDKFswSdRyO8F
         2ZatKHhLQZ+EhVSGbcC0SckqxceYOVnKoIpCpQ3PDmet2atmg97CMPv/mgVSzQvVCQmQ
         gvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242367; x=1761847167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfBpxcQetznup7hF07KUJDBVrurA0aaR62AdWj47guE=;
        b=RRboAstS109T+Px7wpeUPYIbdHVX/mmgb88NM4r+d2K3bN0hlhbplLwXLfYad56dOF
         F8haW8PZ28GIE73VNYiTxV6/Eb/ZpSlSKj+d98d7BbNkEHbWAs75SNbnfPryA+jPii4a
         g+CI5wu2hSz6+xvfoHL/WlQJnT8WU5bFS9FI48sLv1iNHBxc35WJBiYq9MT1pea1tLuw
         p+iTXfrj36X+7nnA8gMnwXhFNibYT+NTgmItQYvfbFxV8JP3ix0oq92GoKBmPOZtB4zD
         kisneTGYs5JJijxq5975gDioUSZTHEZAkgRZFldgGTXTQEnCtbwcrHv9yoko2NlWNCSM
         80iw==
X-Forwarded-Encrypted: i=1; AJvYcCW4uDHTRC8XFH/HAHUSbr/cp7euFNy86ulTG+sYs+EQf2/utTPZJfyZVUwXhG+A9PiDKDh4++aWPxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0Dmm78LoKxw3EEwdDefQbrwezoCE1XDhQ8sZxRP5xbph+cDL
	+OnIVb+Wi2vHVRvueRfBaswSIchocEJa0a0sJvz8JQmtFw+vT3NU5DQL4MNzZzTI+54=
X-Gm-Gg: ASbGncubCm+zGCGewHvjkvoWNWdiY5VQhgTKTXp9LDZzfJoze5yAF0Ho9elcqYqtJjc
	V1fFgm8H1oeHjAhY5XXb0emp/KbTMa0IOG6Xqfmx0LeWfl+LPH0JPEL8d1Mq9gO+msbSEBWR7sD
	dJxQ6dzjtGdjgqOrbYS9dX9mBdFi9iKnlymE4p31qv3nkT/XGkyDchh6PKQfLjV9bUS8meHlX9P
	wza+p+YVsspYVfi1NNnrjtiUPbgrB6Xez73bLIhYxG2UFT/7ITK7pxjDKOxii0a71SBtCDYX6Pl
	aih/4afTfzNb5p2uqGeAzvhYUUPiba44dZ/MrExWJnN1UWFvzmAFxdvHwMD6OpRg3rBXKOQ0nPd
	mOKntQDKdQnpEHIYaDi+UY1SUILQtyqRIsydRmd9gEOSceBHhTNhqlg83fXzeiyZbNeqDQDsKg4
	vut2hK+fM2ULlB8IpdLBgXbqu85tqhs2Sq5g==
X-Google-Smtp-Source: AGHT+IEiskDsftPBzROd2WKzvcPRxdNUDdrslLqgJ10XkgDdwMsWJwp/kE4fHkTeBllQGtyODL0OHQ==
X-Received: by 2002:a17:90b:4a47:b0:339:9a71:efd8 with SMTP id 98e67ed59e1d1-33fafc8fd43mr4507074a91.37.1761242366629;
        Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Thu, 23 Oct 2025 12:59:13 -0500
Message-ID: <20251023175922.528868-2-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
is the first non-Freescale device represented here.  It has a nearly
identidal register set, and this binding correctly describes the hardware.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Point out that this is the first non-Freescale device used here

 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index f2dd20370dbb3..5e6aff1bc2ed3 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -22,6 +22,7 @@ properties:
           - fsl,imx6ul-qspi
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
+          - spacemit,k1-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi
-- 
2.43.0


