Return-Path: <linux-spi+bounces-12465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E181AD38B45
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 02:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A83D0302518A
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA32957C2;
	Sat, 17 Jan 2026 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="X0McLSz5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AB286413
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612933; cv=none; b=TKHSV4nLI29xW6UXGtkGGIbMutsAfIEUHBVts1rATqvPoNxlFGA2iAsXi8bcEA4JeVLNu2mVupvEV00ONcJcQd0pxOdEVj0IjqfWNA/U3aUsxPjpcv6k0WdsUCxunKvNbqWvn/sXCqvwXjSmB38d9QvbVChz0oNyoeTS5AVWYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612933; c=relaxed/simple;
	bh=B+/+PTm75bB4jcTridEbaDWAIvys2S5q2IqRCz6uDz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGYdAYLnMI9NkDdPiFR1zWEB64UTKJycbn4ts2/xN9nuGt75QVshTK0HZNCTpGcBFAU7jx+91N+xREieY/bAT8IYEcFjtphQ5IBSlfsAXjgbo388iABARMW47WYn2VDhfUWGbCneqxgNTqlBUHiyxCrab17hqZkI0KeDg1mDjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=X0McLSz5; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233702afd3so3309936c88.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 17:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768612924; x=1769217724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUAaJXmI/F/1af7Net/YmbJOyQv7O+4kkKkCTpHdDNs=;
        b=X0McLSz5H9iIwu//4xcfWNmAHjA20f097q+4KrRG/YZ0TxHKpwZreTrOEABWFdz5wu
         r0F9UjVzf058OfGDeGQhp0N7cl6+DCPu8Ksy1i9ThqBSTGDwmnjch3qo56XUNIwB2isl
         uevVv7/h/OsGVnMgrq96dvRzyJDPTSnupqVWfxX1utbZLmag3DICQy73NfqMdyK+3VIj
         LRLgwDQqg41F1FwWmd+Do7WncdTf0ko3XwEOP35kA+8H+V+pnwQPuBV6FlHPz7IWcD9G
         aZMTXrzsS0qiae7yBzxTayj+o3Y1trFpDeqNXCAPeF9XttaPEM5sxpckm5aLOf2cQhtZ
         6onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612924; x=1769217724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUAaJXmI/F/1af7Net/YmbJOyQv7O+4kkKkCTpHdDNs=;
        b=ZBkxzhb/QQo915spsDrefT858CnqBnk6Ce1N0y2dtVsQBsmFiTNlFRTYiTbwRm1kuL
         hvx+fDx/cWN9fUq240+9axJ88d7MaNlMYdWdtlohqvivQqhOztmePT0wVWDXvaGQY+dp
         HLYE7rOCq4zoZaH0xWMuEu6WNo35f0bO5CE2eqRCGjY+4xsR79VWbaA3oLoiPCXrh6Zw
         sclmYdtsd7QZFi+OnhgO2HhILILol8qKl3zSiShVanQSahQyJhhlBHE8guSL2jZbwicR
         +Jmry4rWoPOWGFy6xx9dPkBRD7CajSSP6wBV/UPQBS7egbs6IvKsabo3CN2cYFGt/uZW
         v9Gw==
X-Gm-Message-State: AOJu0YzdHubTzuz3ZFOOF+uarnHYQEo8vLZ1WfciWUUvSbQn3GFDAYZ7
	V0AirhfYwWEdsb6XvnOzfLwUkAAnSb0556kvcYFOaTtIRREmPp+mNyDxtcQ8wW2gYcs=
X-Gm-Gg: AY/fxX7GFsziqXysxrftzDPA4Xv+5kl0e6wcNERgv00toH8v0LTY++pjlhLy2PcwoQE
	/RBGWrkqhGyY4PI3VIaMuwqS8SIgLHAqOJqvBK21rzyBiEYakHUoNqazRqc2VkpzcttyG+8hCdo
	NgyDtfZ/X+v4LgV7L7pbmXy8Fikmg/tWVJ0n0qMIzZyvVZygh+/N4Jo7syB6DrL1qeI3wrVLjBr
	Bb8zZan+Dyq1JRND6fmjiHj39Bv9sBJXLFuqYjW5+Nb1a8ytjvTRMNKMWhUlHWv8HktIww3thtk
	xKqn9rJlLaYBHIt766260rCmI9dgghvnUYmJ8n1twR28G3ymsPBPjbEcCYWCeGonFcjxPchlK56
	PgItX53rAjT6NRAJVrDGl2CnmB1ftyjiqQimV0M7QsVsz8OkJjmmxR/Bx8J2+2toB3u5Ul2qb9z
	GJXzqxdTbo14A=
X-Received: by 2002:a05:7022:6988:b0:11b:a514:b64f with SMTP id a92af1059eb24-1244a72ae90mr3884422c88.13.1768612924273;
        Fri, 16 Jan 2026 17:22:04 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm4388151c88.4.2026.01.16.17.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 17:22:03 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 3/3] spi: dt-bindings: xilinx: make interrupts optional
Date: Sat, 17 Jan 2026 01:21:36 +0000
Message-ID: <20260117012136.265220-4-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117012136.265220-1-abdurrahman@nexthop.ai>
References: <20260117012136.265220-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the driver work on platforms where interrupts are either not
provided or broken.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index 4beb3af0416d..24e62530d432 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -38,7 +38,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.52.0


