Return-Path: <linux-spi+bounces-11260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB97C65548
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF3B435DD11
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB742C11DF;
	Mon, 17 Nov 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YHdUW7Jb"
X-Original-To: linux-spi@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225E304BD4;
	Mon, 17 Nov 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398453; cv=none; b=tHcaRu11FW6Kpo4xo5e3LnbSIecC+z9tDctR/8rTuoitgTKiGeo2jA3EdgYF/EvDS4BwGqCvia8cYZs7tdVCrizRRVyE7dSfB2X3gcXq2p/qVdD+T9SqmB8X6yOttzKgocYczI+TVf5tUKNQMlpZQxFHYcchcEEFdVx+khPbB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398453; c=relaxed/simple;
	bh=hmWY5AtRee33yX8ps5wmd9gexmvGg0Sh91HpfKVSxGE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wb30B4oZsD67bMzV8jd3CY3PmsZejyZOelLG7WSK08jpBFAXDWsiJdaWNZJRXGEJiXdckb9iSHxG+Adg0CFXlEhm5vJbaPBfr+Vc5G+LLqRVJJR6iAWlyefKK8iuItGdDZjCTFwB1yi5Wc5YuvBslkwVfaLf1VGvkT39TDjT63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YHdUW7Jb; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763398442; bh=hmWY5AtRee33yX8ps5wmd9gexmvGg0Sh91HpfKVSxGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHdUW7JbWrhDsJAWJulqyXwcoMFpAR8qYaoNfUGO8cdBOH0d35v32ginPB1r2LyVf
	 pAaRRiDt8CUN7zlanWQdBohqVxiq0AHLuQxAZbBZGHQvd/Mt9jl864ns1s6GGBphI1
	 H5vRdapaW7a9h2144nnEjdjhZA6K7U6VXEc/bluw=
Received: from localhost.localdomain ([2401:d002:1207:ce00:5cbb:f6ff:fe9e:eefa])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id D68084AE; Tue, 18 Nov 2025 00:53:40 +0800
X-QQ-mid: xmsmtpt1763398420thjfqrz1x
Message-ID: <tencent_AD45099B2ACD2FBFA150B8AF87074644C705@qq.com>
X-QQ-XMAILINFO: MILSKRzDrLPbbDAqOfgupDwTnlLnUsWn8vCX9wyp4pnZcGCLtRUiLK1L08/KtK
	 CFU5Y+XSes/VpPa8c5cBgqW/1v16mrUrxyO2x9OD1bm2mRz/amSQPl5Wt/TneBGbtuaNf996AJtk
	 5EghR2S9qWuG7B48T3hI91/lu7mMWWmwoCAidRCosdzb8UMtBBQPLoqOiqokiJyr1KcaFHSn1EQY
	 8Mt4AxLmLm1LZK+XgHWlyaACx0vwZTJqlxp8un83WRlw/TVCXh8+idJnDC9eEznX2XUIKCBFDOm2
	 eYc4CTQUFPqxNCibzqFMUAI7ED4C/L5gBWjUj5ryP8lmKv0ZQlrP1Ww6V3lLRcnwaF/Ar8rp6C7N
	 SKzf+nUMnxImyreAK7HKdi29keSsoeVdnpnSXoqQm5uvtF5UzsOlvrFLrjSsmjLGwHLofvdIuy5+
	 ca75/nKlztJof6vj/hmRZ/d/ThBdykN1+KlU2xi3KX04fNK2Z9HIeD89DxbwBS2pw6IeGrgXiS2B
	 lX57wxJUTNAnrbXn0duAdfxU7b8N6FUjqP5gGLTMf1MHttox4TldEtfXhvdr7u0UNTYob8A0YSDk
	 Q0nCAFIShIyQaduNPeciM6Od0r9U6khB/DhDF2PNFCC37mEGHqAO20IImhgWdDIAG9PsVdTqbW6Y
	 Yu0YTAyiii1xXOxiRgwvPky5MXq0XM0U78tossDRiXJ1eHLDVSmAwXlQlmmE/xcuUXgOCg39fC+k
	 Mck/eHDyTwkqaKibqfuExHw/Bz7QbziWhhGfYdJYj2HVK9sTeg3QEK48Rp1gBYNAnBNgFCPwM4AV
	 UuYFyZNVIG3U+M/dQssTigj2tDf2DzW4rgJTPYyPTeqEDVl2Hb5/q8YYUWnqhJbvlEaDQViJfiDt
	 PdkhHVQWPNyIaCcTvyugdRSJt6rw/zQpuAhS+eKNOuKVFbPTvlZ6b+ml66/V+MAd+J7L0V9vHkcr
	 RFi+dC4OTKuUoMWtTmbN5Wfk6dbx3Cwx3TZ4k0sfcRCUtmZRUZOPkODU6h61kJAEO8sY+meXD359
	 kseeHo5hUUcuyb0+Le8pS3okgvnKjAX7DYyc+cH3jQUgo7xi+ggwPaz4BapI0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Hang Zhou <929513338@qq.com>
To: broonie@kernel.org
Cc: jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: bcm63xx: fix premature CS deassertion on RX-only transactions
Date: Tue, 18 Nov 2025 03:53:38 +1100
X-OQ-MSGID: <20251117165338.213687-1-929513338@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aRpF3jRTs23YrPgC@sirena.co.uk>
References: <aRpF3jRTs23YrPgC@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mark,

Thank you for the review.

I initially picked 0xFF because in most case, the SPI bus is high when it's idle, but in practice 0x00 works just as well here.

If you prefer, I'm happy to switch the dummy value to 0x00 for consistency and respin this as v3.

Best regards,
Hang Zhou


