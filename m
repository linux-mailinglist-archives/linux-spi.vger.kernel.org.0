Return-Path: <linux-spi+bounces-5963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6BC9E8693
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63446163DC5
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AF16F265;
	Sun,  8 Dec 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oaPqqLwk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610ED14658C;
	Sun,  8 Dec 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675772; cv=none; b=VF3BU/TrbWDei+rzt46iT8J9t4230rv2iawT7YxvnSLkA4mmtIbXl1BZzc3nD9QaBA20CCkKmDdvv/j62H4qv645n8WkBi/Wl7SsfYMRDFgEBF8C1RxGBEZSvlp4nca68Uij019VBkBsBwqbNdkokbx16uNEE0tHyCBhlHvAJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675772; c=relaxed/simple;
	bh=qCa4kvxOl0P1sVVRedcdgekkUruVWwO2292zPpbn3FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWTBxcvexPLCg3gqK4d2ZkjfhcFZPu0HyyJ3Lc2eQAD0iXFzt4ba39fWeT2S3ygnqGibLY90t4ymCEsABJTh7N/wYkffUXByUuJsEgcw7F6XcPfzTM5s0ZaQd23feRyV0smUPOd2oQNe4b2k5UQ9SZJ5MWwqI52MAHrmVLpott8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oaPqqLwk; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KKGDtRDVse9OfKKGDtIAcu; Sun, 08 Dec 2024 17:35:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733675759;
	bh=1BlT9mAMhtajgq5Sd0M9ZitjekhFYHZJ1fMhlgsmQME=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oaPqqLwkZj+zm7i/P9ZqQgbYwnRGFFByToDoE4AWI2LJSDz5XDKfStPNvFpJVjBvW
	 fMvggSBAaQvdZLqSsqEuyue4ZU/TxLkRZdwwU44dyzm3W7yMPyQad3QDmQAFSy+nxF
	 DE5Ns8YnoBnZYi2rWWi3hcnNLZoPVS+GBwvSe95purO+KldUNPmkwfpcU2AuDFaxfH
	 SE7FLGhsbEqu8eMsPESAnMNuIUR4WtBTrAV/UAg+mN6SSWchH2dOHvfWnv2FH+iTu3
	 eIMbmVnZzUprp1ySl0VVwal/CYoW/F6ifZ/QeD76cn5yR0FLEKSv/FnLEI3znS+pDV
	 baKMmheO6xhqw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 17:35:59 +0100
X-ME-IP: 90.11.132.44
Message-ID: <c0206c74-33d3-4715-9a01-256394919fc8@wanadoo.fr>
Date: Sun, 8 Dec 2024 17:35:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] clk: at91: sama7d65: add sama7d65 pmc driver
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <6cf9921c6d312193c34f6f5cbd9eda7d0f9f317c.1733505542.git.Ryan.Wanner@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6cf9921c6d312193c34f6f5cbd9eda7d0f9f317c.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/12/2024 à 20:59, Ryan.Wanner@microchip.com a écrit :
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add clock support for SAMA7D65 SoC.
> 
> Increase maximum number of valid master clocks. The PMC for the SAMA7D65
> requires 9 master clocks.
> 
> Increase maximum amount of PLLs to 9 to support SAMA7D65 SoC PLL
> requirements.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

...

> +	for (i = 0; i < ARRAY_SIZE(sama7d65_gck); i++) {
> +		u8 num_parents = 4 + sama7d65_gck[i].pp_count;
> +		struct clk_hw *tmp_parent_hws[8];
> +		u32 *mux_table;
> +
> +		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
> +					  GFP_KERNEL);
> +		if (!mux_table)
> +			goto err_free;
> +
> +		PMC_INIT_TABLE(mux_table, 4);
> +		PMC_FILL_TABLE(&mux_table[4], sama7d65_gck[i].pp_mux_table,
> +			       sama7d65_gck[i].pp_count);
> +		for (j = 0; j < sama7d65_gck[i].pp_count; j++) {
> +			u8 pll_id = sama7d65_gck[i].pp[j].pll_id;
> +			u8 pll_compid = sama7d65_gck[i].pp[j].pll_compid;
> +
> +			tmp_parent_hws[j] = sama7d65_plls[pll_id][pll_compid].hw;
> +		}
> +		PMC_FILL_TABLE(&parent_hws[4], tmp_parent_hws,
> +			       sama7d65_gck[i].pp_count);
> +
> +		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
> +						 &sama7d65_pcr_layout,
> +						 sama7d65_gck[i].n, NULL,
> +						 parent_hws, mux_table,
> +						 num_parents,
> +						 sama7d65_gck[i].id,
> +						 &sama7d65_gck[i].r,
> +						 sama7d65_gck[i].pp_chg_id);
> +		if (IS_ERR(hw))

If we fail here, mux_table is not freed, because it is not stored yet in 
alloc_mem.

> +			goto err_free;
> +
> +		sama7d65_pmc->ghws[sama7d65_gck[i].id] = hw;
> +		alloc_mem[alloc_mem_size++] = mux_table;
> +	}
> +
> +	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama7d65_pmc);
> +	kfree(alloc_mem);
> +
> +	return;
> +
> +err_free:
> +	if (alloc_mem) {
> +		for (i = 0; i < alloc_mem_size; i++)
> +			kfree(alloc_mem[i]);
> +		kfree(alloc_mem);
> +	}
> +
> +	kfree(sama7d65_pmc);
> +}
> +
> +/* Some clks are used for a clocksource */
> +CLK_OF_DECLARE(sama7d65_pmc, "microchip,sama7d65-pmc", sama7d65_pmc_setup);

CJ


