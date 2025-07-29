Return-Path: <linux-spi+bounces-9202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B1B14BA2
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A03B5A39
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522B288538;
	Tue, 29 Jul 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Si5zKBPB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3D2882DF
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782676; cv=none; b=Qc4EBBqVohZEu9+GK8F15MAVpIakt80Th1GmUy0C/bPe0zFjylbybB7MzLE7wwqwCa5UIFkU5nRyi7I32ornNNRw2/x9CbySj7kARrXO5wJywHHZ5MuSI5HEsST3/uhI/yBlQCRyLpnzx3jarNn3tTFhlmdJzvUPoKAizYFfPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782676; c=relaxed/simple;
	bh=PPTY3EBWf/otaI/DRQ2USIoaVvA+G2t6tbNhqLyGWpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKqUHxn1CGuEkwMG8w391AkW6OxI8UTiUJMfohKuOLVF8rYpCMu1Y3YTCdnb6kZInMGsxln3nMKdYOa6OEDRQttC1jmlIPbv+KiakSqgTwyRaz/s9LJYZZJJEWGx9heZ7AGHpuwrcIVWFg32UdwesNy0rzp4WtehCDxgLmxF+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Si5zKBPB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4466808a12.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753782673; x=1754387473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhMEhDHuJe50c0Y9oEddnTStIZgEJGL8EToCa0MeNLo=;
        b=Si5zKBPBWkv3QYgz6sM+faPpFEXW7WEzHa8RnsnQ1Z19ByqgKHvUGp+jMwkwwQFSAt
         hk+LaoB5PIxJ19Uweakx/bB8Z6tQxAULt9Q1K42jDJ6pR5ak4MQeWyNrURNtPQixtR6f
         ORLxuMbBDUUn+iyNkdW0q4WYEjUljQaL3AhXC9wt3huWwiknbLdE2+eJrXuk41O507/R
         swA3k71486od3OFt7rO5JgQvyAJhP+IxfQTOQ1scbWvr3C6YLlpIPxYN1IOxVag880NV
         CscnfqV+zg457XXKmSQgC8V7iWpxV4WyRo6QOnO1ZjpMMnQ0q4Z6FGV2WRhZ2d3diTMk
         qJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782673; x=1754387473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhMEhDHuJe50c0Y9oEddnTStIZgEJGL8EToCa0MeNLo=;
        b=YnSnVLLUH9TJ7yN/IEnYhu2aTFL14lm8+jVf9NwGqWLosOUo5/ZGM5E4FBOUx9I89v
         EuoB6faz1KwPROFVcgKQA0flm4ipmYYrMLlbYw1yTlntisqVM4fBDX3RKjyJKjaWptns
         9y2RxBt4ExxN+3lc0uc4eg/b/mqEE1PONdBIdQAsZdKL+VXUu8ySvEd4mbc3VnOtBYwC
         iH1FSqG3P6fFQ+7hWwFLQdqFN1rB1U5NC1IrgtifLX712aBOo3Kg/EsJHgz6qyZmpvuN
         rHG8fNH2QpJsYt8TC9F+F9B+U8k4Ulowb7JKYoB3/S/n7xMgb89GtjmzndPm+JLcMwBd
         QWrQ==
X-Gm-Message-State: AOJu0YzkbSi2pmLwIqmXZpt3Zhk3BCPS5AJxI+O4qV69P5jbnQ3w2kwf
	zAu7ojgj3horSGQ4cm2XCu6C+MHBc+jQGBd8nxx7k0CjHqLRbJRatDnypWu/StMwYA==
X-Gm-Gg: ASbGncsz4A/CjMfuTalxo2AyS1lVu12w2JizIHQQxZQSiXNNnNlCU65/Wwp3O/V3ZS+
	e2dcqv91a4EKq1Zm6Jw5kO6FpLdbFS/lFo1m7/OEOBFrfB0RiVffoDS4B8f69KPwjrqRJdWEbhY
	PmDWdYOkRaO0ws1jbb5iHikweao7x51VYNzaUsrIpknx7G2aTUJ63mbQYHwOJfGb1xwHbP2fEeC
	yuERnK7iXAPy6+7nO/L8IulkxjkH0iCPuhljpX0NwqtaClFm8+JJEYNqxMxM9P/rI7mKClgC8Oo
	jg/XKH4eLlJn0150DnwoUgBxuhcsMV8ID2eAW50ZCoN6HL3id/orY8SUyBSHF/CiE/+JxVhiSEY
	Yz4gXSqMINE067opkL9uIvrJKyeGSQRw=
X-Google-Smtp-Source: AGHT+IGRuN4bMTuKrqYVdmJqVFT+qoKQgtcZpI2ah8oemY7i1w0uPXl3QS2dGd9gd7nItemsFz9mgw==
X-Received: by 2002:a05:6a20:9389:b0:229:1130:7411 with SMTP id adf61e73a8af0-23d701be41bmr27749974637.31.1753782673040;
        Tue, 29 Jul 2025 02:51:13 -0700 (PDT)
Received: from [192.168.1.6] ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm7614498b3a.117.2025.07.29.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:51:12 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 29 Jul 2025 15:21:00 +0530
Subject: [PATCH 1/4] spi: Follow spi-parent when retrieving a controller
 from node
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-spi-bus-extension-v1-1-b20c73f2161a@beagleboard.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
In-Reply-To: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, herve.codina@bootlin.com, 
 luca.ceresoli@bootlin.com, conor+dt@kernel.org, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>, 
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=PPTY3EBWf/otaI/DRQ2USIoaVvA+G2t6tbNhqLyGWpk=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBoiJmG5oK1u3pxCYpL6Jz9P9NBiai5vv4OQcoKS
 bZqdgUe5LiJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaIiZhgAKCRAFzvXHieVa
 dBMxD/9iSM1YQUhhkrVc5EJX+S0biAoTFOAqBhj3SPxY6UyIhsMbskjA9OdK0Nhc9ZgGTSjW6MI
 LnogxUC1yOqUnn7B5R3ZW9NFIoahwD6ySrunNRFSHs857hFlJ+ruMvZjVcZncQG7y3Uz5kpVZn7
 3B3gWpd/xTcGjF6liaZ/QNF6WicZnkekDp+NtIR7t7FQdf5KEQEuESSiXKR0cDF2GbvdGgUnrNa
 UlFvSf8N6iCHQJqlvyX7NIBmBlHDBzcYfV6kJY/NU6k5V1USzv5S7lY2gJdxTERIC93fr0pedP2
 oGJS2tmkOiGgpqGdX6aHUTBotGWknshtgKh1pUFLvbN9Y0efCkj+WrHMZmWrVsLJVp2p/efcnEZ
 VUEk3C0ZaBWS6WhFfdKnl/JSBj5cjZ4zY1yqA2GfB7M4c3hrMKA6W5y5ER9EXJvB1Rrn5pjl4UZ
 uuu4fUpzTf7Htd9pQBzPvKsr/31tNIhQkFvVd3lBmpqVinvlGOUWYzg3aOWlC+vq7BmpmgWT5w6
 T/v2YNDd+FftndKZ7eFHH2PBvSbdTCkkftLOv2btA94VhpDC725xzI4fpijPIeOUuWFq4cTmZ7x
 Q9IPS8UuriWMsfH0oGNJdQvTQ2x9nzrRdWOUOSniqC/OoHeagnojcFM1YTtIxFnNgd1I7wjyy4P
 kkHtdQUxvOIejvA==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

spi bus extension were introduced to decouple spi busses when they are
wired to connectors. Combined with devicetree overlays, they introduce
an additional level of indirection, which is needed to decouple the
overlay (describing the hardware available on addon baord) and the base
tree (describing resources provided to the addon board).

For instance, the following devicetree fragment, available once
overlays are applied, is legit:

```
spi1: spi@abcd0000 {
    compatible = "xyz,spi-ctrl";
    spi-bus-extension@0 {
        reg = <0>;
        spi-bus = <&spi-ctrl>;
    };
    ...
};

connector {
    spi-ctrl {
        spi-parent = <&spi1>;
        #address-cells = <1>;
        #size-cells = <0>;

        spi-bus-extension@0 {
            reg = <0>;
            spi-bus = <&spi-other-connector>;
        };

        device@1 {
            compatible = "xyz,foo";
            reg = <1>;
        };
    };

    devices {
        other-connector {
            spi-at-other-connector {
                spi-parent = <&spi-ctrl>;
                #address-cells = <1>;
                #size-cells = <0>;

                device@2 {
                   compatible = "xyz,bar";
                   reg = <2>;
                };
            };
        };
    };
};
```

Current implementation of of_find_spi_controller_by_node() supposes that
the node parameter correspond to the adapter.

This assumption is no more valid with spi bus extensions. Indeed, the
node parameter can reference an spi bus extension node and not the
related adapter.

In the example, spi-ctrl and spi-at-other-connector nodes are chained
bus extensions and those node can be passed to
of_find_spi_controller_by_node() in order to get the related adapter (i.e
the adapter handling the bus and its extensions: spi@abcd0000).

Extend of_find_spi_controller_by_node() to perform the walking from the
given node through spi-parent references up to the adapter.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a388f372b27a7f29d18f1dd5e862902811016fc6..0030e0be0d9b2f9e2b0c4a1d806b42bdb4ecb5d2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4776,11 +4776,18 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 /* The spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
+	struct device_node *ctlr_node = node;
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_controller_class, node);
+	while (of_property_present(ctlr_node, "spi-parent")) {
+		ctlr_node = of_parse_phandle(ctlr_node, "spi-parent", 0);
+		if (!ctlr_node)
+			return NULL;
+	}
+
+	dev = class_find_device_by_of_node(&spi_controller_class, ctlr_node);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_target_class, node);
+		dev = class_find_device_by_of_node(&spi_target_class, ctlr_node);
 	if (!dev)
 		return NULL;
 

-- 
2.50.1


