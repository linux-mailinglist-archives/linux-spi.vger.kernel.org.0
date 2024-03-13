Return-Path: <linux-spi+bounces-1786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CF87B0D2
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F14428F7A6
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6B4086B;
	Wed, 13 Mar 2024 18:03:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4C69D2A
	for <linux-spi@vger.kernel.org>; Wed, 13 Mar 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352997; cv=none; b=gHHeimOB4ZdyQrFEb7StHRZI1DqVNtzDV/cpcWzntCmcHDKU8INY2CUEJ3YMD/qVQm7EwF5QKy9+8jBvlyVUXh93561MioRQFuQjbY3tqhesi9LX7MZAFFgwjjaulLabIsWOBDjzY4st7V1JBtwZLvf45cjahglavnrMhkF4+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352997; c=relaxed/simple;
	bh=Y2Z0/3xow7nPavZadbi94o6aySaUf4dO4/vQqQPCEIs=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:Message-ID; b=t62uoLYiXclzLpX6E/MfarEi0fYTvbryVeUAHkOmyRiDUBJy8uzZd0Wtszc9KIYeWik1iJJQ/XxsIeaoXyIHCNiovc05+yMcAkR4hNDN1QMRyGlqCZsrJOD5J49yKMX0LFNVAFwlodWphcu1DA5+Fx0oMUs8AgJUrOuhJdVln0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=none smtp.mailfrom=jessamine.co.uk; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jessamine.co.uk
Received: from webmail.plus.net ([84.93.237.82])
	by smtp with ESMTPA
	id kStYr8pPPcsBEkStZrac4p; Wed, 13 Mar 2024 18:00:05 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Go3h+V1C c=1 sm=1 tr=0 ts=65f1e9a5
 a=k49VtrWLZTL8DnM+6AvpWw==:117 a=8YZdF9bm7lDkcydB81w8Xw==:17
 a=vpjNtYboqT8A:10 a=kj9zAlcOel0A:10 a=K6JAEmCyrfEA:10 a=ZBkl__CYAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=_R0pZofXfCjbRRL6lAkA:9 a=CjuIK1q_8ugA:10
 a=d6WIyDdLbVARuAyufDlf:22 a=AjGcO6oz07-iQ99wixmX:22 a=ST-jHhOKWsTCqRlWije3:22
X-AUTH: jessaminenet+adam@:2501
Received: from munkyhouse.force9.co.uk ([84.92.42.80])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Wed, 13 Mar 2024 18:00:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Mar 2024 18:00:03 +0000
From: Adam Butcher <adam@jessamine.co.uk>
To: Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 benjamin@bigler.one, stefanmoring@gmail.com, carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Message-ID: <30b2a315b36e1ee16c0217b32b95a605@jessamine.co.uk>
X-Sender: adam@jessamine.co.uk
User-Agent: Webmail
X-CMAE-Envelope: MS4xfNAd/d3xNc7akxcdpSdbmEU52kI977HmdV1aqlg6KJKnoOaT4G+sI3vNrEtMFWSbhVBJRIRBEn+/Wo1KC+g66lB8X9VlIV8otAjltYiXk5DDt3e+Ulbi
 6RgMTtrbXPWgtXh2gtKjea/wRk7wLYt4nOaTAJNJEn5H8w57mQdC/BoPmiAJa7VzoGZ9/jgVspjKgJxay06yZsJGYHdTNmam4Eg=

 From: Adam Butcher <adam@jessamine.co.uk>

992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
corrects three cases of setting the ECSPI burst length but erroneously
leaves the in-range CPU case one bit to big (in that register a value of
0 means 1 bit).  The effect was that transmissions that should have been
8-bit bytes appeared as 9-bit causing failed communication with SPI
devices.

It seems the original patch submission up to v4 did not contain the bug.
It was introduced in the v5 update.

Link: 
https://lore.kernel.org/all/20240201105451.507005-1-carlos.song@nxp.com/
Link: 
https://lore.kernel.org/all/20240204091912.36488-1-carlos.song@nxp.com/
Fixes: 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU 
mode")
Signed-off-by: Adam Butcher <adam@jessamine.co.uk>
---
  drivers/spi/spi-imx.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7c1fcd5ed52f7..100552e6c56bc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -743,8 +743,8 @@ static int mx51_ecspi_prepare_transfer(struct 
spi_imx_data *spi_imx,
  				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
  						<< MX51_ECSPI_CTRL_BL_OFFSET;
  			else
-				ctrl |= spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
-						BITS_PER_BYTE) * spi_imx->bits_per_word
+				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
+						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
  						<< MX51_ECSPI_CTRL_BL_OFFSET;
  		}
  	}
-- 
2.43.0



