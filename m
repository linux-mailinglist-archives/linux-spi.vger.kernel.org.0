Return-Path: <linux-spi+bounces-6811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F7EA34F90
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 21:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66944169EC0
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F851266B5F;
	Thu, 13 Feb 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvFi2eFM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63240266B50;
	Thu, 13 Feb 2025 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479267; cv=none; b=G44V/EAPtXHubuNbtZzoppJSMI9XgYm7Vp0pU1zrvx1VcsdkXJdYcbAzOIENrALdyKCi/2rQvABTlul+eEcYw2yrCCkGsOadhk4l7zeShoCzKOPz8zF9NERfm/BjBwB0iRWipI4Fl+gA/frf4Gwzea8F36x1FTP+TY8YMvg3b3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479267; c=relaxed/simple;
	bh=04ewGkfCnt4dGtPWuETy+xnmdSoDM6RaH0T1s0ZJ1RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBwUiJQoMAukj/RzFQN8mMUyVfCvIAxyNMZ3JkWbwMx/8YHvLLAQd5IwS5xL4fCFofgHKXBuD4E1febffdhP7bV8eY15v6UVFBM4yF980DcIWovGK3CGgnqzpuijWu6pXztXEXb9NPgX7EblOH2RCXmNQUY9CzuGNKPDvOD6IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvFi2eFM; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52066e96433so395669e0c.1;
        Thu, 13 Feb 2025 12:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739479265; x=1740084065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=RvFi2eFMCHigRleqwxkUkK2dtdFyYQEv3iHppmbMDoMAwe7ktagXmor7gwJRjMZfjA
         m0qlPAllaNr/6nV9O3dm4Cusxwd4jY++NOvdTsqDUYrdxDKOnoVxBZcDo6lNi8zqHI5S
         dufXNGpUJpptOh/Qltzh4Ko3LlbT2JvWtBjq7NV5GJGzKx8GsoRvOxMg/iwQyNk6jNuP
         iK43Ek+c8sPfVIhuO2fbqr6yL5vmxWoNrPQ6Z5YwL/wAVzWK5TGgbWaY8vV9vd8S8UyC
         t51NX9vfXxysN0GLB4Zi5ThUd910lAyTVFzyk5uFjioYVmALrXONVOibCtksmKituHrb
         teeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479265; x=1740084065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=GA/rPeJP90OxGMTzIG0TleUbuj0C7ljylUCurQawuqAwEbXmpZYSZLL8ua7ehk9GNJ
         ORKQyu7ZY/p1RhMImHsEGRPGBq1TrM9m6cUhtFq0Osjf4pFc5ok76SluQZs/OfphibiB
         ynwcHnQDxmDZj5pxWoe4RKJ7VhSXxHBU5aZ4bIfcWCBEeesc3vVlw3N9/9fEFyPX83nc
         6ZUfviX2l7re6fMvANziOBWF1SMjaMRtkjEsIlL5kqmqF+qR+n2NIwc7vYpPBdNuWWpu
         jCY+TlmwTUafqsKFle90GNNyJwFBY2O8Etu2CFy4wdxn4ioJPNEJZ2WfmVTbOHELRNwZ
         1+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU80FeqRYUnPLU+6ZEIuF/o8pwDexPcntA3g7khwC5dmko2m0sAXLIrAfkKZf3S8bMeQ9gbKI+CJmo+EBFa@vger.kernel.org, AJvYcCUHRW8SMD2WoCPYuamewByLHaMzsMY5ZaDULTXgNLuuV+X374RF/u39z6ssvHkhNpd9ZVogfdizGN3R/RV9joJa9wY=@vger.kernel.org, AJvYcCUYiIukU18wL8fJhcN3zIUd/RVvv85nkbpTqe82RtLW8ai2bq2/hcvYzLP23XnUUgkGgD44LAqqgaip@vger.kernel.org, AJvYcCVywQUDuTnXgj5oNAM2U/HfXcnQdiEWKZAJWSVOc8JBH+DXN8KDs00oLW648ia6XCZy+WFyte6TRRlt@vger.kernel.org
X-Gm-Message-State: AOJu0YyIH9S0Ph8Acy3jt9Y+JseMYCCkfA5wydPxB1N7lEiwBP0X3neD
	h0zqwxK9LUR4sgx73AB7KJEUoMgdqbFen8Bg4pm+6+X5YdNC+sIv
X-Gm-Gg: ASbGncvsR7MTRC2MfUtoM34Z8vZdkfnfYKVZOssdtd2+7bnshq56Ve1gupC4emvNoqt
	O+uEqrS3+Ub8o8kd1Lu8mCVttLvRaF9jHPfigQNi+j1lmgDLSJR7Q50rCCagYFQjqjCAIuHMJRI
	3KwB6gMQSdyn/c1s8jYeXGh4TJHnTZb6IsqbR3oHPynlKvIKLdsOhVgU6tlGftRsePIAs9k1lkp
	eLjAKyc9sHzBI4Z7TxQMMewSfaiSWWL2psIBo0VCEPk65KU/k0PJdX2LyZZQPajnFwaePhsRODH
	O441gdjdGXzpUVqeKQ20JDJg+zNzaAxbuwhxYnpsYCsAEzZr8A/Ueryh0VKgDnSrPo/LEJajO41
	oDA==
X-Google-Smtp-Source: AGHT+IEhvth2aVAFgZnYvs2HU668sqO6z0dn5SU9R5BGr77aqA+pRXB0bdFJZpLiuUpt/W31Sq4HaQ==
X-Received: by 2002:a05:6122:3109:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52067bf1a31mr9044764e0c.2.1739479265197;
        Thu, 13 Feb 2025 12:41:05 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa40088sm285572e0c.10.2025.02.13.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:41:04 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v2 1/2] spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
Date: Thu, 13 Feb 2025 20:40:43 +0000
Message-Id: <20250213204044.660-2-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213204044.660-1-wachiturroxd150@gmail.com>
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
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


