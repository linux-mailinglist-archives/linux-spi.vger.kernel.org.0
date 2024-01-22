Return-Path: <linux-spi+bounces-615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FC83773E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 00:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AA5288A93
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0854A986;
	Mon, 22 Jan 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDKUAU0K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7F495F7;
	Mon, 22 Jan 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964405; cv=none; b=pl5jo2ZKRcVH4bg0Kk1qUaV7+8tLikfjOK5eK2OoeSlqYxme908/gYV5LZUJlquuq7e6nxNXmqkRQjYLURZqTUaJwHl880KowpEjSLWLqmzFyVopail0Q2wVauuPH1jNwe39jKGj5T6QNZbag/5rnwbpxk8ZCYfacvry1F5WrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964405; c=relaxed/simple;
	bh=4g6ByT2Cjr1ZUCYpcGnj0nFwDlrTTGSfGWGcOG7bnAc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uuYN9ZsF3s6GoQe4l3mZuk1Ahjckk33UTl6nJSGKhQeUhVkXRDZKkyx4dsUVYSJ7hpVxPMpJj7565REp7bmop/ALZEKmBnMG8mRFEf5khtLTKiCXvNQQCWrsevwXB/Xf3932ZeT2d6XOr0zU8sBBwCv3FmIXOdh38tIqDByAYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDKUAU0K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831806c51bso361581685a.1;
        Mon, 22 Jan 2024 15:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705964402; x=1706569202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDQ3kSgI1n12mI5nrn3g+XPsCvC4mRPQnsGuoeezvgE=;
        b=DDKUAU0K9fPC66j8+MSioCiR60+wwS23XoA8mPDft4zwSPGXJp04IYYDw3w/GcYTMw
         2zY6RC8OfcfH+fwXw/++k+PA446bPIho04RKTkP/biRkjDiorhtMHJ697GEhuaQn5b3q
         XbDGAQNj769lfEZ2J4t19eGQrlBaIKbH82AG/12iQt21M7VJYKVP8wQgs7qUOMun/bBE
         PwZ0jJOl8gjTdW6poWJ9/bl1dXJ3RyIOF9XNzEhUVtKGVmiFzH08b8z4H3MSMDVScjmH
         WBU29CPpZvli80/Ff5C+gwEKzScd0XjkbC6s1izePVve495KnGoVmMRm3WWf0x+Ng6Tw
         Fcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964402; x=1706569202;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDQ3kSgI1n12mI5nrn3g+XPsCvC4mRPQnsGuoeezvgE=;
        b=UATR+VlHym9g1Iju5NK8fIalHVA0Y5HSsR9NDhwKTETQISk2MN/3JpV+Gg3fE/nnfj
         ZEyeu7IV+Bx6TqzKOsv3heGPI9tO2qfznsmus+Y1+aaadtMQ+DVczwPdsVlupDSfexgL
         ZEgyUd/yNmcyXBSXOZMkGkQ7py3nUpeJkxzshKq6O9SI17JvgUcrLGVcNohLtAXaqx7w
         Em1fVTBpGMGjlpSWu2I7VZHPZ/2Bg4p6wpZNeP1UroCZsqJw1ktEMAdQufVBS+c55wVV
         ZSn6XcKdGnTKDBm0e3a1VMU3+pgASXCybLdhX234tgHGVJGQse0Tmw4QZ3YhsWkW6v+3
         ER1A==
X-Gm-Message-State: AOJu0Yx7VKF3KNMq5y1uSY5BRGXoIv7nq8eZ/FrWHDn67XukuW/GX/X6
	TBRNzGwJrPLtgywQgx/qVsdNagILzTy5U/IVPGZew0c4/jtRv6dHH/PcrBAy
X-Google-Smtp-Source: AGHT+IGJkTlFEHNn6yJK6JzzM5/LvZ7r1bv8G+xBy9qdytZ6LJMjNamlDx6fOM91VLg3VDlFLNnWEQ==
X-Received: by 2002:a05:620a:f06:b0:783:792c:966 with SMTP id v6-20020a05620a0f0600b00783792c0966mr7149725qkl.65.1705964402450;
        Mon, 22 Jan 2024 15:00:02 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a004a00b007838702be74sm2524649qkt.104.2024.01.22.15.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:00:02 -0800 (PST)
Message-ID: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
Date: Mon, 22 Jan 2024 23:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
To: broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the driver spi-rockchip.c max_native_cs is limited to 4 and the
default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index e4941e9212d1..00d555bcbad3 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -65,6 +65,11 @@ properties:
       - const: tx
       - const: rx

+  num-cs:
+    default: 1
+    minimum: 1
+    maximum: 4
+
   rx-sample-delay-ns:
     default: 0
     description:
--
2.39.2


