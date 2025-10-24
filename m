Return-Path: <linux-spi+bounces-10829-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44BC07DC8
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4F35599B
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160EE36A5F6;
	Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="l57nNXDl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7636A5EE
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333359; cv=none; b=nFgZmC4qLr+dnlxVACF6ND4aPf5di19sT7nPDtttw46DBV0xdlc4GkDQK+v0Q5SDAVCRgUG0nRyt/sTD35CCdlExmmyQAhGL+JwpCvzyCr0vrg06gmaHD09+eBSaDlT28dJ+L3KYeO9Q2OmmFLZHaKDJ9uJ2qZ1XSfaHnStQ65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333359; c=relaxed/simple;
	bh=nMCY7tqu98IJzjclxpQyavU8U1FNBOGWdu3yx7Z5f6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uualwpvD6sEdplpsJEOKOLIZ2jXcfKnUjKk5alz0GgXob3aXdVX3FFGeI109sizMZiZXkizsFf/BlSqKya8CiJnzvNQC16T/Pex2taUlPwCgAGvFfbGa5N7lwk892eYGdZi7zvJvojV7aUmvH24ULWlAQ4d4Z0Cpn4LpW+DJVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=l57nNXDl; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430d08d56caso11071575ab.2
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333356; x=1761938156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOGEEJh/33D603wteGhrxPA31YJMUwUVVAtQyDoqnvQ=;
        b=l57nNXDl7bnjlngt9goGzF6apwW/CBG/7s5RfSvAHyIXvPXyrwxoiXJ8uH+Se+euWK
         lXt9P6YZD2ADrBcur1gr9Kudqy5NidCj8CnRsJJMQiX5lT/azUiupbWk/8UBwXMhymsb
         G4VPa0xk6dQSiBd7BcUaTvacaWNnxItESfbf7J8ndoBX8HNzh7xu+U2oAycAN8J3in7C
         70lZOddK06LrdJDWhwFhSJG25ynAgARhgN0z6XOWmvfYzNX1K4iFfIP3pNHgkYnvgx5W
         j57LBK/YhJEqqOlnYCSt4PkMDXVP8+3veJT9UtwmTHqOmjmEekh2ZfQ7Z8H0PQ882iCF
         KPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333356; x=1761938156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOGEEJh/33D603wteGhrxPA31YJMUwUVVAtQyDoqnvQ=;
        b=IOFotVWYlaghcCY2RmFkhFFmGp/NFkXJnmx32RxyLsf0vbzOYoUU/qJmssUWOm8TZu
         okFJRhZUczDBh3Y7Ck01d5Gf3eJyhpUk7ofCHDOSiO+u3q2hlsx8Pr/2/VvLw4DHM2LM
         hL7hG7+4JLzp0vqhhFdXpxav7m09wLJNArhJa50dfaKqPVDDViiDwhZMPdq8g11EfEz9
         Hu9PIi3/x38wlTMyIqx2WxjWg4BISUGT+xb0TLTTF1FIiTNW3/cgpqZgVyn+jpeEYVr6
         p9720xmBKx/i/xm6vLvubkYblU9cRQNzCKfUsJG+FAdsJ9CYiCCoRAR1AB0XC/CXTdYF
         AhAA==
X-Forwarded-Encrypted: i=1; AJvYcCVBYfNcz8UiUL1JKmk9vLqFw5y1RQKijVjxilf4AFQc2mRnx4iY8CVXqBGlBK9GxSl8bQWCOrtK28w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL94AOzeP5GDOdU82nBoorTW7ilTauxtgBppLFUtP1rqQyky3X
	j8tleftyT1vxZuk3lSYd1RkLix82X4aRx1NhACHtrdTdXs0N+HzVoqJeKs/SULoBTPc=
X-Gm-Gg: ASbGncv8RncdpOikAv9pMOR9eoGAasX8sL/DGCwqMuu94IJFot5WnCuvOEGM0u9p7OX
	rlgYnwDu2xsA4k75gUb7QPeObs9nrIkzatuDMbkuCSrDs+oCf21bqUy3tLz/DnIcSceaDlliDD7
	lKAdSLH1m3J0dqzrVEHCcW5wmPnXMgTgu8tpcytpD9YC5LmQPc1t6ZvBcGUvoxiirSZY9yvTMT7
	kiknkmBGjy+6kA5t3/40Hgz5DLzcLMfbuSgQIwsuI9wNIgJOFwkmmh9+BmSkIjlywynd5gAjTfo
	Y1ZmPxRJrut922f16hTK/mzKbbGS144oAacg+LwWDDZlW+mYm104LbPZO22VKd5tuACBIcoLIwD
	wBH3YJiCLUKpAHVBB3VHjIB9lZVTfOElANnixq1y5Dl15TMkkw4udLkrIAZCX89wq0oBL1vBEPw
	rc9PD5U1mLqe0gax4wtxm6orNO60TwvPdrI109Nt/esnhCyxSLKkMqww==
X-Google-Smtp-Source: AGHT+IFDogyL6cWcfQwc3FAklbFwL0iLqDuDqQppxCvEgv6jdMEMsj7R+FgIMqftII9RxRpxH7qsMg==
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id e9e14a558f8ab-431ebed79admr44368525ab.27.1761333356161;
        Fri, 24 Oct 2025 12:15:56 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:55 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Fri, 24 Oct 2025 14:15:41 -0500
Message-ID: <20251024191550.194946-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Added Acked-by from Conor Dooley
    - Added Reviewed-by from Frank Li

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
2.48.1


