Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1D2D84AB
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 06:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLLFP4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Dec 2020 00:15:56 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:43132 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgLLFPZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Dec 2020 00:15:25 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 4937020CCC
        for <linux-spi@vger.kernel.org>; Sat, 12 Dec 2020 05:14:44 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 2C1952008F
        for <linux-spi@vger.kernel.org>; Sat, 12 Dec 2020 05:13:52 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 587E13F1CF;
        Sat, 12 Dec 2020 06:12:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 289532A7EF;
        Sat, 12 Dec 2020 06:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607749939;
        bh=eC+/mRVV3IfQDjzKV7feRYEg5BPAUoKHp3qINz76Op8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9tc5M8GGVIyzcUU+RdoJTuXZ071jgww+aW2MOxCxETHTFyqE/BV9gezMgZBjXFdv
         HXJAhe6xC41M/aQQdBEmwCCyExmPAT/UiVxahqj55QOYPWkJAI59r0+DGriGUPxDGw
         5t78BcTw5lQvsv9dmNPWgFtB9lequ9n2BR2GhIf0=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R7CqmRB4-6OK; Sat, 12 Dec 2020 06:12:18 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 12 Dec 2020 06:12:18 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 5C32142F57;
        Sat, 12 Dec 2020 05:12:17 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="O1hWraWN";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id DA98942F46;
        Sat, 12 Dec 2020 05:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607749933; bh=eC+/mRVV3IfQDjzKV7feRYEg5BPAUoKHp3qINz76Op8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1hWraWNUbKjJ4t+7ICgJcEf6Ck00BBSKjLVr7xr69Q6StlST8vS1ZwAZCp3X93g2
         jeOKyKvxhRrHIMnHDEzeJrJa4R6/uPA/uAswkuPy30iB7PnpdK3hmEFiREaT0X2G/i
         LHGRT06PGpa/Sj3XAWdADpL5QdljrEvXsqw0CFK8=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [RFC PATCH 10/12] dt-bindings: spi: sun6i: add compatible for V831 SPI
Date:   Sat, 12 Dec 2020 13:12:00 +0800
Message-Id: <20201212051202.3645115-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201212040157.3639864-1-icenowy@aosc.io>
References: <20201212040157.3639864-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: 5C32142F57
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

V831 has a SPI controller similar to the H6 one.

Add a compatible string for it.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
H6 and V831 SPI controllers is not totally the same with H3: they have
QSPI support added. Here V831 compatible string is just added in
parallel with H6 one, but maybe we should make H6 SPI do not fallback to
H3 one, and add H6 one as fallback to V831?

 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 7866a655d81c..a620ff30033e 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-r40-spi
+              - allwinner,sun8i-v831-spi
               - allwinner,sun50i-h6-spi
           - const: allwinner,sun8i-h3-spi
 
-- 
2.28.0
