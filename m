Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4031572D4
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgBJK3b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 05:29:31 -0500
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:40732 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJK3b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Feb 2020 05:29:31 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 05:29:28 EST
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 48GMQ06H65z1rP;
        Mon, 10 Feb 2020 11:21:28 +0100 (CET)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 48GMPy6XZKz1XLDR4;
        Mon, 10 Feb 2020 11:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1581330086;
        bh=hXz+af7JZXSKV0aRQtsoM6BXQxHvMRCVT482aSFP6FE=; l=10;
        h=Subject:From:From:Reply-To:Sender;
        b=WdI8ImR2Hu26jqg7BVI3EeACBQGxVEA5OHO0GazrndOgfLl34BW+a7iTkA9ac0BGP
         nK6fRT6czA+81HQmhCFU/xu3qHEgwij9o0lPycczQHhiED8bBfU+fGwrnlGQlzwY76
         8lSTfeUMPHa1cYlAf3JyHFz1JVwrueg5GCYmIHow=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 48GMPy65r9z2gb;
        Mon, 10 Feb 2020 11:21:26 +0100 (CET)
X-AuditID: 0a3aad10-8b5ff70000004724-8e-5e412ea649b3
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id DB.97.18212.6AE214E5; Mon, 10 Feb 2020 11:21:26 +0100 (CET)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 48GMPy4CPTz6CjZNp;
        Mon, 10 Feb 2020 11:21:26 +0100 (CET)
Received: from [10.34.222.178] (10.34.222.178) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.1847.3; Mon, 10 Feb 2020
 11:21:26 +0100
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-spi@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        <linux-renesas-soc@vger.kernel.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Message-ID: <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
Date:   Mon, 10 Feb 2020 11:21:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.222.178]
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0wbZRjHea/X9tpwchwUHotTdwtKNsdAkR264OYi6R8aFpNpNA49xtHW
        AcW7QsaMEXQyuulgccDoCJUNx8QsQSbyY3OyZiFlThigAh0lMBvjGEJHgz/AWe9WWPuH/7z5
        vt/n+bzfe597CQXtU+sJc5GVF4q4AkalxbXPnFu3+UzyjpwU1/kk1lH/Cc46rgwq2dHeRhXb
        eWseYyvuTKhZW/9txHqmXDh7rc2t3k4YpmsDmOF6yzmVofpuiuGPa8dwg7/j4V3K17Xb8vgC
        cykvbMl8S2sarptQFLdu2m+/1a8uRwHmMNIQQKVBXeuX6DDSEjRVj8HN5qPK4OYSAk9NLx7c
        tCKo7T6ikpEYKhPmPqpUyjqWYsFTcepek4IKIPD1VK2eVYFgYOGIWu5SUelwu8WOZE1Sz8Hl
        Qz6JIAicSoTR5XTZ1lF7oL+rUh1siYaBBi8uaw2VBePNc/e0QgprcAyhoI4Ht9eBBfUj0PV7
        oyJ4n/XQ6TmurkG0PewoexhuD8PtYfhnCG9Dunw+pbRwa0Yqmyzk8uKBlNTkvZbCDhT8O1Q3
        6rma70QYgZzoaQJjdOQ+3Y4c+oFcS16ZiRNNbwolBbzI6Mn352x76Jj7tliSW2gWRbOlyImA
        UDCxZEaCxJF5XNkBXrAEMSdKIHAmnjQS2W/QlJGz8vt4vpgX1qrPEgQDZNJmCYwWeCO/P99c
        YF0rM+tIFBERQceFV8JjMULjRE8RkVL24hNytljMFYpm4yr+YBCn19wQehVt1ceTj8kMJVdN
        JUX3U/UPkYNZmTm0LqwQImfROCIQE0OS8jdHSk89lAdkuTyi6FUzBD3ZIjGUPwqaPhCgqXsJ
        QfvYdxicHxnG4OKiH4PJT+04DHzfgYP7r3YldB+cUcJIr10NS5N9avgnUKmB36aGNDBctaCB
        k6cXNXCpbiUSpm4ORsHlmZUomPQfi4ZqWwcNSxe6peXsBRqu1I7REPjKHwvDLrcOpmaXddA0
        MR0HrrO+OGj0/QLw8bcNeug5+I0eXN4vEmalWWLSLMfStsuztHLW/5nlqhu6nL4cbeTyT/CC
        dWl8aPRvdzpn+/m1be2vvD2/PmmDpv6u31H3p/HDmffGAqdHd/8w513Y3ffjv/qRwMkbnoul
        r1YN5WVd9z6ac7SzzPKC8dBOm/OnvvL2XWcm7ry7s6balk2/M/PrljRb4ssr8W2bpp/P3ruc
        +FLGfNTK8RftvubEx8WvP79xoovBRROXulEhiNx/JizsOoMEAAA=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On 10.12.2019 20:39, Sergei Shtylyov wrote:
> Add the memory driver for Renesas RPC-IF which registers either SPI or
> HyperFLash device depending on the contents of the device tree subnode.
> It also provides the absract "back end" device APIs that can be used by
> the "front end" SPI/MTD drivers to talk to the real hardware.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


FYI, please find below [1] the changes I did locally on this driver. It 
seems to read & write successfully on my custom M3 (R8A7796) device, now.

Best regards

Dirk

[1]

 From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Tue, 4 Feb 2020 08:39:31 +0100
Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
  clean up

This is required to make the driver work correctly in my M3 environment.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
  drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
  1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c 
b/drivers/memory/renesas-rpc-if.c
index 04be92b64bfa..f4356b066384 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -129,10 +129,11 @@

  #define RPCIF_PHYCNT		0x007C	/* R/W */
  #define RPCIF_PHYCNT_CAL	BIT(31)
-#define RPCIF_PHYCNT_OCTA_AA	BIT(22)
-#define RPCIF_PHYCNT_OCTA_SA	BIT(23)
+#define RPCIF_PHYCNT_OCTA(v)	(((v) & 0x3) << 22)
  #define RPCIF_PHYCNT_EXDS	BIT(21)
  #define RPCIF_PHYCNT_OCT	BIT(20)
+#define RPCIF_PHYCNT_DDRCAL	BIT(19)
+#define RPCIF_PHYCNT_HS		BIT(18)
  #define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
  #define RPCIF_PHYCNT_WBUF2	BIT(4)
  #define RPCIF_PHYCNT_WBUF	BIT(2)
@@ -219,6 +220,8 @@ EXPORT_SYMBOL(rpcif_disable_rpm);

  void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  {
+	u32 dummy;
+
  	pm_runtime_get_sync(rpc->dev);

  	/*
@@ -227,9 +230,9 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  	 *	 0x0 : the delay is biggest,
  	 *	 0x1 : the delay is 2nd biggest,
  	 *	 On H3 ES1.x, the value should be 0, while on others,
-	 *	 the value should be 6.
+	 *	 the value should be 7.
  	 */
-	regmap_write(rpc->regmap, RPCIF_PHYCNT, /* RPCIF_PHYCNT_STRTIM(6) | */
+	regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
  		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);

  	/*
@@ -250,6 +253,10 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  	regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
  		     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
  		     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+	/* Set RCF after BSZ update */
+	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
+	/* Dummy read according to spec */
+	regmap_read(rpc->regmap, RPCIF_DRCR, &dummy);
  	regmap_write(rpc->regmap, RPCIF_SSLDR, RPCIF_SSLDR_SPNDL(7) |
  		     RPCIF_SSLDR_SLNDL(7) | RPCIF_SSLDR_SCKDL(7));

@@ -291,11 +298,11 @@ void rpcif_prepare(struct rpcif *rpc, const struct 
rpcif_op *op, u64 *offs,
  	rpc->xferlen = 0;

  	if (op->cmd.buswidth) {
-		rpc->enable  |= RPCIF_SMENR_CDE |
+		rpc->enable  = RPCIF_SMENR_CDE |
  			RPCIF_SMENR_CDB(rpcif_bit_size(op->cmd.buswidth));
-		rpc->command |= RPCIF_SMCMR_CMD(op->cmd.opcode);
+		rpc->command = RPCIF_SMCMR_CMD(op->cmd.opcode);
  		if (op->cmd.ddr)
-			rpc->ddr |= RPCIF_SMDRENR_HYPE(0x5);
+			rpc->ddr = RPCIF_SMDRENR_HYPE(0x5);
  	}
  	if (op->ocmd.buswidth) {
  		rpc->enable  |= RPCIF_SMENR_OCDE |
@@ -432,6 +439,8 @@ int rpcif_io_xfer(struct rpcif *rpc)
  		 * mode instead.
  		 */
  		if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
+			u32 dummy;
+
  			regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
  					   RPCIF_CMNCR_MD, 0);
  			regmap_write(rpc->regmap, RPCIF_DRCR,
@@ -446,6 +455,8 @@ int rpcif_io_xfer(struct rpcif *rpc)
  			regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
  			memcpy_fromio(rpc->buffer, rpc->dirmap, rpc->xferlen);
  			regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
+			/* Dummy read according to spec */
+			regmap_read(rpc->regmap, RPCIF_DRCR, &dummy);
  			break;
  		}
  		while (pos < rpc->xferlen) {
@@ -506,6 +517,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 
offs, size_t len, void *buf)
  {
  	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
  	size_t size = RPCIF_DIRMAP_SIZE - from;
+	u32 ret;

  	if (len > size)
  		len = size;
@@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 
offs, size_t len, void *buf)
  	pm_runtime_get_sync(rpc->dev);

  	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
-	regmap_write(rpc->regmap, RPCIF_DRCR,
-		     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
-	regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
-	regmap_write(rpc->regmap, RPCIF_DREAR,
-		     RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
-	regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
-	regmap_write(rpc->regmap, RPCIF_DRENR,
-		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
-	regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
-	regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
+	ret = wait_msg_xfer_end(rpc);
+	if (ret) {
+		len = 0;
+		goto err_out;
+	}

  	memcpy_fromio(buf, rpc->dirmap + from, len);

+err_out:
  	pm_runtime_put(rpc->dev);

  	return len;
-- 
2.20.0

