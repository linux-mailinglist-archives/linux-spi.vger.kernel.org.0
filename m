Return-Path: <linux-spi+bounces-6793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DFA32F4E
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179ED188A308
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B342627ED;
	Wed, 12 Feb 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDTzvNil"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9E2627EC;
	Wed, 12 Feb 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387585; cv=none; b=UXbaYF6s8z7JR42UnELYjGNaPYazTRuk0DtW33yCJxqy/6o3pE2OvFEDoTUdeBM0MC4+22bAi1c7tmYE4+5sIMygI7bvjhfWhYFSrdLbUoRyfvAtqDFPsme/FrxQpg9E9eTmhGtwxRoNrM/j7qnihggiDmMO3w78abPHrSeV/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387585; c=relaxed/simple;
	bh=04ewGkfCnt4dGtPWuETy+xnmdSoDM6RaH0T1s0ZJ1RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bjl/VcL6VH+k3785TjUjELk0xVaSgrzAusRhMBApuSeBCiw6M1XhLypaAUnaLjaOn87urXIG54ocvhen/FyY4k+LoHomOsC7uiXgKSlN4FYSJqCM/FlLZ3pcxRFsLC8Dg+LRR1+wqWHphwyhH6HYwokNfUOKoJmSCl40AMt28zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDTzvNil; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f710c17baso246715ad.1;
        Wed, 12 Feb 2025 11:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387583; x=1739992383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=DDTzvNilgb7iFoCP+pAfRr7XvDcC49aZ1xU3D695Iyt1tT/DI4ptTeGFIWv+MIqMuW
         0Q9e6w4zPT+FlR1z07Dc4BXrWVGnH/loE39NV80quB6o4/Vhk75sbMsYsvnDzPRzbi2I
         mIOKfPC6K4S6xyzyDzuZhUPwmqzVgQpnZinbGUwDFVIa48N30FUYYhEcEN8IRIYD8vp1
         Wr8H/idjq+fkfrKXIro0f37reeGjjYLwz56c+lVfDSDfWCvnbcxEYjBez6hUkwNhtrMk
         Urwu7GoNXXAOzCU2b48nX8Bn/TXYs4++RBFN2U6ePzr9aL90JUcwQMP+FPjwMCESxkuJ
         ZtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387583; x=1739992383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=BgNYxIsSYZmvYJN0t5vqkPoKmOTNhrif0BGWA5Gokn7s+SDhItOonuct5rkxOKSybd
         rxWN2bTav4hfZOMbuDOghdu1naPF/os5d1vyX5I/ZN0IHQqZYqtmMadyFL1c/lj/3bJ5
         8DJhfS6EHGj2Xtx58Ahn0sO3db9FcXVxxt0IfMOdSo20Z/GZ1OnvCDgXY6WBxOSf4FT5
         1w9qK6I49pCCErJA6lmTnrmopRfNf9gwOhJNpC6Tp3rC7UWmlz+/tCy4Vztiq44KIRVG
         Ztcuk6Dwhkct3hywCN41QoFoxyeppdvo1TVzCEkZRABxx8R6lgBRDZpPCHVGLtHe0pIR
         FbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU23wdUzUIQxREMgzPf45bOv+4/zGu07KDEX3o+bLLx7qHaqEtk39nS2TeFKcpnZN4diZLaXedZwn3JmN+1@vger.kernel.org, AJvYcCV3FWvtaqG0cwCzdzDvvFLT4QVccWw5rHWDNSeRwe6Uk5/suQSJDFUjIK4ut/A2EtMdac1TMAlGqtWg@vger.kernel.org, AJvYcCWLKio077ySwgOh4yd/2vp+DcvH8QqD8OkrHttp6TNkeQ/LzWUPsBQVdEgiigOuMi8erpBSBXU4XXFMbLM4Vpmdskg=@vger.kernel.org, AJvYcCX9vi4lBuEsopUURZXNf+G+UFXNTI4v24L5ypwvgYHMrMIV7KxWSyUrVPX1z3kYddQ8nxzYzZytQySV@vger.kernel.org
X-Gm-Message-State: AOJu0YycFnxpJKixbxWRT79mdOVSuAKe7sv7cySC6pHBxYS0E2ThNuGV
	iggeUsGdK/wypDGbckJlluSMN9EwmzkY76n00omSqDmiUd2069PaqbLFrrM9
X-Gm-Gg: ASbGncs3GRX8Qu/u2UeiNkZyNQc/WZiuseR43JJa4JmFGlGcwzySCPaRSzOO14JT6PM
	iwALQENiTVo6abVRK9fMs/LTUXic4zHAxTulHylf5uLrXhbB2f21yUcxq0YULphPRp9Sc3+yNmQ
	O2WbUCTFfIEEgshWo6TM8PXxEIDuh/115omyfLK0PrrOKv2zVUClPsj3btJVI4VDAaR76wigdB/
	286G0UbaXYnHH5sT3VkkAbpnFP6U1W0ca1IxuUk5H5MESvu0+THpA/3tb17V9LqVnoNBU7EYIYn
	lco6xqqNxWY+rqXuG1Iu24gdsT45c6EnooQwxm7AE2hQD+XqHftZIZJ/RDVslcx1obeIvzP/kas
	ndQ==
X-Google-Smtp-Source: AGHT+IFwhx9qe0p3LuepYHTsbWN3x3smfLDE7DI8Ahudl0uVY04lMZzW6zWdad8DMjVaCWH+CLzlxA==
X-Received: by 2002:a05:6a00:1aca:b0:731:43ca:5cc4 with SMTP id d2e1a72fcca58-7322c3a21e7mr7297950b3a.11.1739387583347;
        Wed, 12 Feb 2025 11:13:03 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f79sm11536944b3a.77.2025.02.12.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:13:03 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v1 1/2] spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
Date: Wed, 12 Feb 2025 19:12:40 +0000
Message-Id: <20250212191241.280-2-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212191241.280-1-wachiturroxd150@gmail.com>
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
on Exynos990 SoC. This ensures proper representation of the hardware
in the device tree.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 3c206a64d..1d3c95bd2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -24,6 +24,7 @@ properties:
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
           - samsung,exynos850-spi
+          - samsung,exynos990-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - items:
-- 
2.48.1


