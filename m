Return-Path: <linux-spi+bounces-5313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B49AC990
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050DA2825BF
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D241AB535;
	Wed, 23 Oct 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIZiUXlt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45F1A7AE8;
	Wed, 23 Oct 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684844; cv=none; b=mKj3RZOa6+G4bl4jkQGiSMq0dObp1QmcFg4QqGgqa4tbalmvkzbgZZMZccuwkj5ZpU1h+Axtsz3oc+4ZGYkxXqrq1bJKCv7YI892W/Ezcs8rDH36c2QfnOOYxsyH/tCx3fzrCDRjZ1amd5kWAPzppTRVe7tU7e8yzjHddq7f+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684844; c=relaxed/simple;
	bh=1IDOPztULiFZZL/MxYm084uNsK6vnVeXEm96dK+wNCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOAiQbNXwzyLT5DyCU/U6KyKFOZtPKrLOFKKu8fER5vI2mygysRoqEzbojeAVaqYtDlhBEevnrRlSjGYGElk0jHMVfRCQav8/odTnhrloQLSF25lg19H6Fvd1TJzPRUf+c9kK+FMssjz3C8rjQFW9/FJTCh6SBfBUjAm16+Etno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIZiUXlt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c714cd9c8so67336735ad.0;
        Wed, 23 Oct 2024 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729684842; x=1730289642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOY/HkOxNB50xnp7x+ajUwUdjdbWxkY0M0g4fo6JzFc=;
        b=KIZiUXltlxpX2mAGVyI8Sa9c5J+mrePBaxlVHU+63kZ5zD20teZ8KmUKSHRtg8gMeU
         gDhEtOKDw7uOPId1fPl0ZgelUwLlXfB7EArdQheRRiswTBMogSaLiJK22lERgxobJzCD
         c28QTq/f9ta3f8/FJ26WP3Qbv6LBz1pSUA1D7ef2IT/9RGzk30cwdNb6yP3wyDQ08GAr
         tlab6p9dTZU2TmwQTI/L/PO6rwWUNOK/xt9T/Stg+FtgvyKAb7h+tySK0qCE4F6/Af/h
         6dWjtLREFzXjAX2FC8mH59WASIfkQFlYqH6lb4CvNRaktZA5jm7lUWaNx+x0/gNF141w
         zDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684842; x=1730289642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOY/HkOxNB50xnp7x+ajUwUdjdbWxkY0M0g4fo6JzFc=;
        b=Ot2UES8Mntu+YmJT3CG7ZWiMgyz8foia45a1OFDSZmbEzALBcLRH43Ev4BWkQe0JFe
         81T+Crx25MF3Xe5SCf2ADmaDQJ9Kx+l0yCJDuT7SX++XKmS+F07fomgq0sxvrSCvWQYL
         1sJMsKjSOCtADfaXbTRktdsbYL8gy9oWH/Us9LU58zjXF4qZCgABm4aIkKO8avBZnvAo
         WfFFlQpSPtiR44MUNOjliOmsliFvvpF6YFN3dr7WEtSDQGgQG670l1e8iOaYpLz4Hylg
         APqjHRIgIAPT5h1njG8RDWB+5xdWsQ8SwbvXVr5PTzlsjEFnX2+NSwtRd1j7Qk8MjbUt
         btng==
X-Forwarded-Encrypted: i=1; AJvYcCW/cDq9hs98gw7QDW9dW6CvqXwUz0rY94UOlm8hcShByIHfsMeC4s0N6B76iQl1ONnc04ZJzWDjUG9U@vger.kernel.org, AJvYcCWhaOtZ0HrCL1QoEZLDUz0Jsz/r/gb6WKsX3gXlqPgx7euoV9oRXhofTC3hudqb98dp9OVr2M72AeuC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuubvv0UfQ7RGWhFgDhHDWG5+PzpsC7UJRCTmpaX2j0CL63Yo+
	X4YPyPYErhf7EwVSjB3BQ1XiFRAyQEXeA1nmqCw38SJMT8GDbS5M
X-Google-Smtp-Source: AGHT+IE2z2rgTDRpyrkYQWHG68gvu+DxblmY0KnUfOWDVVdfkdenFstPYhh6CgdIUqvmZsVyx1Do9g==
X-Received: by 2002:a17:902:f550:b0:20c:a122:e6c4 with SMTP id d9443c01a7336-20fa9e09ad8mr30838995ad.14.1729684842256;
        Wed, 23 Oct 2024 05:00:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3468:366c:e529:6d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3665sm56598825ad.271.2024.10.23.05.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:00:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] ARM: dts: vf610-bk4: Use the more specific "lwn,bk4-spi"
Date: Wed, 23 Oct 2024 09:00:15 -0300
Message-Id: <20241023120015.1049008-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023120015.1049008-1-festevam@gmail.com>
References: <20241023120015.1049008-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Currently, the compatible string used for the spidev device is "lwn,bk4",
which is the same as the board compatible string documented at fsl.yaml.

This causes several dt-schema warnings:

make dtbs_check DT_SCHEMA_FILES=fsl.yaml
...

['lwn,bk4'] is too short
'lwn,bk4' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
'lwn,bk4' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
'lwn,bk4' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
...

Use a more specific "lwn,bk4-spi" compatible string to fix the problem.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/boot/dts/nxp/vf/vf610-bk4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts b/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
index 722182f5fd17..2492fb99956c 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
@@ -119,7 +119,7 @@ &dspi0 {
 	status = "okay";
 
 	spidev0@0 {
-		compatible = "lwn,bk4";
+		compatible = "lwn,bk4-spi";
 		spi-max-frequency = <30000000>;
 		reg = <0>;
 		fsl,spi-cs-sck-delay = <200>;
@@ -136,7 +136,7 @@ &dspi3 {
 	#address-cells = <0>;
 
 	slave {
-		compatible = "lwn,bk4";
+		compatible = "lwn,bk4-spi";
 		spi-max-frequency = <30000000>;
 	};
 };
-- 
2.34.1


