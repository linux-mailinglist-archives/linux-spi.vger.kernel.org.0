Return-Path: <linux-spi+bounces-10852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBFC0E0DA
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3643406ECA
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53900213E6A;
	Mon, 27 Oct 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="s0V4aX5f"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D71E491B
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571818; cv=none; b=nTidncGvzpMdD4aTIwdLSUkay4kWdzf7uf5DDS+iEey/IkyGtTINsCd3S/eYerFejF2s7E7p2O+p4geCKmkZtyEsE3SCUz/pTnIPrl9UPNEdfxq3kghXf1orA3FXnPamthQY4ZHPFCqdMWOBDI3/ZIxcTeauafCpUDZocx7qunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571818; c=relaxed/simple;
	bh=r/29WdZEJajnpJ//0j5XUaaOQFUOGpajFSIL6DbCOUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9ZS33j2snU9tbYRdK4U81pS/chnF0ZpEBpx5NK62LTMgI5JL4mnxUpgCCG3MK5/wCpQ3hQn3y/4hy+eiqau3r3UwQrB4odlaFfAWhEaB5XwlcKbv9lbjlMsOq0Lvxy3zdSjn7//q72enG9ZitW3nvH6EKhn7zDIRLKS7tbKwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=s0V4aX5f; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-940d9772e28so187601439f.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571815; x=1762176615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtUb4xhiKPpq0C8FtRKPFcwQ9IWnX8JOlp4x+Bp+m94=;
        b=s0V4aX5fK+TDl2n+8a8GRZLtIyZ+SxocDjtLOpOlkurci/Q5a70MXlfVBoQi7YJgWd
         NQbv/PJfcHUg3/ecOPIHSOkyPSRaS2FTxpe4hV76rkVJ4deMsOsE3Ki7ZCE3Pa8dGJfH
         j/vNBwxLyIKhusGlClQGMiXp4xINISedXrOgSRGT957ECWagi2/2tW+5LKdton9urrVv
         fqESnTVLBwhlcFxJeLYehdjWRpZMQ6rhtyY8aC9W3KgmfJvoW+Ff81hJ/4Hf8gAt/yp0
         jiWWqldWts6c13/aS+ndM/PryAmwtHHQsE+P7PV5fWNZ5t2VNCJMN0ssxY0LGGjna23g
         rXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571815; x=1762176615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtUb4xhiKPpq0C8FtRKPFcwQ9IWnX8JOlp4x+Bp+m94=;
        b=qEqmq9zSzO0dX/yv1OEntzKa8W9UfRpkDFuv/e8x0UkX4K2DTeYgZ6A7g5CcEBvcZa
         b7aczkS8fQGw8aedPyvWTCtS69zdJ8fLLxDUix+pTSrnQHLj9G5q0WxoByXfUTrQVj9t
         Q/piKXQkwReaJ5CqEiXU+O9ebg1UurvGdtxNDAWoljJUntKqyEeWNLZxCzstPJH349Fx
         IJ9msB1AdvUbZqiD41kb0OQ1nYSTL7rgeHkxfGPXdWe7/B0HT2sQd1QuxoJoounonlBT
         RNnXTHKlhzMTmpwtafmo+ydcYfk3txMleo6tsQnrjPaMBOgV/WtOMK4jam7+Q+tEFpZt
         Q6rw==
X-Forwarded-Encrypted: i=1; AJvYcCWNwvGYQKtpes0lZ4ggp9VRy32nmkK5iVs/rNbOlBMlkuN2LYP3NGqbNls+QV8V6iiodZpI8hP95tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmQfJGaMSvJvaALhuaSoOLH1WuAnszAzDURWdOw23mFgd6f64
	vzZ6XcBdvjA5TZtddJ9MDyAVkVdn8R6a0sFObtJmaU2kzkevkZlZ9AUAPiUHxkIyrjw=
X-Gm-Gg: ASbGncsXlE8EAkQ6dvqi6GonOdzTIkQB20htMWmD40DlXkV66GVW02MJjZGY+Z2j93V
	Vexz23u13ZUW1evIfTgFJu0QA9N7rurTv8y9BYUaRRBksJaTQ5sn50n4YdA877AfSSExiJCn1UW
	UIVMZM//2Vtx8P0zQjsAkVMbRNo5AmPuBKtHE7x4J9NxE8pm1cGPj+6ZefTdxolJN4/Ne2lHn7w
	YpSYJGNfpbXNPDOnKJp4VmCcQvpzXdc6M/gto/hhNKk+HF9KU3Y2DZrDJtn9A5d7wRNxiUroE4X
	mgTEtI3HhNlZK1TtN83WUa+kP5Yvi5NZIE3FxcuoWRRiYuKMbmOvEDVhv8Ol9jM1c2sa57iE6WW
	tt7VTJNNLwkFyl7QKUaBzC5de5QddGWFyMazO8KWgx8MnPKWAyEyS8dFhiO/u1kjZmW6f9W9RJ3
	vbBhCVLyXja5ZiDBPoARgI49VITT11jd0t/GE0XZs+/pzJAJDP9x4rMA==
X-Google-Smtp-Source: AGHT+IGIaa9c6711RS9OGQdRfQ7Rb3CKIGdpN5d0nvSIOXYlsYNxZJWsYmkF9NyaMUyPnxGqZ/xfcg==
X-Received: by 2002:a92:cd8d:0:b0:430:cfe4:6e61 with SMTP id e9e14a558f8ab-4320f7dcd73mr1143985ab.14.1761571815189;
        Mon, 27 Oct 2025 06:30:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:14 -0700 (PDT)
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
Subject: [PATCH v4 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Mon, 27 Oct 2025 08:29:59 -0500
Message-ID: <20251027133008.360237-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
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


