Return-Path: <linux-spi+bounces-5754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F449D2E49
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5518283A9D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C315574E;
	Tue, 19 Nov 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G8R6rIHK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18078528E;
	Tue, 19 Nov 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042029; cv=none; b=ZX396lYOqkDzmy0TnKbKZ5vXTlBjteTOBkX2gmcuAjqS8GeaSeicn90yxjH43poSLjoIIA2pv/udbQLyM04G4FEKytMlZ0Olt0qrTZclSGpCXEKX4eijcK+04GewBnovT97dtITvt9OYWMDSk9neBI3GJgugL6Yt9hYCVYCRyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042029; c=relaxed/simple;
	bh=JaWytgbPiisX8pvxdqweWT07VNH9/o+4cgnjKLsBIxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAlTnP3dJDhjTmvVW9G8PyoBZi4CeBSbFRRiCo7NPrhEbAQS2O9aRGvRD3wPc2GJuCu3S63p9D7NEWNtRtCA+KN1P6QZNgJwA+3nXHzbnZDGZc5ZYxXp0RXIAEcm/skDjFl0DaKpw+2ZEzCit53+8VD/7kyEpsqulnPlMDxOr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G8R6rIHK; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DTFWt5CAGmK41DTFWt0cNu; Tue, 19 Nov 2024 19:46:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732042017;
	bh=UBYWGpjQPLsx4MqQVn9RTX35vK2sjzBZKj9YylR+AGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=G8R6rIHKsbms6vIV7zgAO/inZ9vm1EVYuy2Z5rB/ETZDH5P5yO+qLWDlYU/Oq8t/7
	 bJb5nMYG9PzrGTEey3AtYoPae7m161jXr9WiJKHPhGzBvdBpdZE7eOJXlsO3m0YFIU
	 FbxiR7efvdVCKbH27twFI+0UrZ1wiCcYvqAq7plh/NpRsaNj4zZy8SH9/gYcUTdYUQ
	 24GvLPk7HwBNRHF5ldMUli4HVKGbHDMWxvxysppZZ+MiCgUXUw6rpOv+RYt3C9QphJ
	 rUSIzFy1lali9z0U3swn6NwN6XSfMZ1Np6c8X4R4KqGXDxPr0TF1OVOGvajvlj2wk/
	 D/l6hOGSmSErA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 19 Nov 2024 19:46:57 +0100
X-ME-IP: 90.11.132.44
Message-ID: <4e351cd7-cc34-4fb2-bce4-1612e46e285b@wanadoo.fr>
Date: Tue, 19 Nov 2024 19:46:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] clk: at91: sama7d65: add sama7d65 pmc driver
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <0b7af2a91d4d58cfd4909d338f1879e14f61f77f.1732030972.git.Ryan.Wanner@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <0b7af2a91d4d58cfd4909d338f1879e14f61f77f.1732030972.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/11/2024 à 17:40, Ryan.Wanner@microchip.com a écrit :
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add clock support for SAMA7D65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

Hi,

> +enum pll_ids {
> +	PLL_ID_CPU,
> +	PLL_ID_SYS,
> +	PLL_ID_DDR,
> +	PLL_ID_GPU,
> +	PLL_ID_BAUD,
> +	PLL_ID_AUDIO,
> +	PLL_ID_ETH,
> +	PLL_ID_LVDS,
> +	PLL_ID_USB,
> +	PLL_ID_MAX,

Maybe the last comma could be removed to show that nothing is expected 
after it?

> +};
> +
> +/*
> + * PLL component identifier
> + * @PLL_COMPID_FRAC: Fractional PLL component identifier
> + * @PLL_COMPID_DIV0: 1st PLL divider component identifier
> + * @PLL_COMPID_DIV1: 2nd PLL divider component identifier
> + */
> +enum pll_component_id {
> +	PLL_COMPID_FRAC,
> +	PLL_COMPID_DIV0,
> +	PLL_COMPID_DIV1,
> +	PLL_COMPID_MAX,

Maybe the last comma could be removed to show that nothing is expected 
after it?

> +};
...

> +static void __init sama7d65_pmc_setup(struct device_node *np)
> +{
> +	const char *main_xtal_name = "main_xtal";
> +	struct pmc_data *sama7d65_pmc;
> +	const char *parent_names[11];
> +	void **alloc_mem = NULL;
> +	int alloc_mem_size = 0;
> +	struct regmap *regmap;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *td_slck_hw, *md_slck_hw;
> +	static struct clk_parent_data parent_data;
> +	struct clk_hw *parent_hws[10];
> +	bool bypass;
> +	int i, j;
> +
> +	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> +	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> +	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
> +
> +	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
> +		return;
> +
> +	regmap = device_node_to_regmap(np);
> +	if (IS_ERR(regmap))
> +		return;
> +
> +	sama7d65_pmc = pmc_data_allocate(PMC_INDEX_MAX,
> +					 nck(sama7d65_systemck),
> +					 nck(sama7d65_periphck),
> +					 nck(sama7d65_gck), 8);
> +	if (!sama7d65_pmc)
> +		return;
> +
> +	alloc_mem = kmalloc(sizeof(void *) *
> +			    (ARRAY_SIZE(sama7d65_mckx) + ARRAY_SIZE(sama7d65_gck)),
> +			    GFP_KERNEL);
> +	if (!alloc_mem)
> +		goto err_free;
> +
> +	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
> +						   50000000);
> +	if (IS_ERR(main_rc_hw))
> +		goto err_free;
> +
> +	bypass = of_property_read_bool(np, "atmel,osc-bypass");
> +
> +	parent_data.name = main_xtal_name;
> +	parent_data.fw_name = main_xtal_name;
> +	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> +						 &parent_data, bypass);
> +	if (IS_ERR(main_osc_hw))
> +		goto err_free;
> +
> +	parent_hws[0] = main_rc_hw;
> +	parent_hws[1] = main_osc_hw;
> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
> +	if (IS_ERR(hw))
> +		goto err_free;
> +
> +	sama7d65_pmc->chws[PMC_MAIN] = hw;
> +
> +	for (i = 0; i < PLL_ID_MAX; i++) {
> +		for (j = 0; j < PLL_COMPID_MAX; j++) {
> +			struct clk_hw *parent_hw;
> +
> +			if (!sama7d65_plls[i][j].n)
> +				continue;
> +
> +			switch (sama7d65_plls[i][j].t) {
> +			case PLL_TYPE_FRAC:
> +				switch (sama7d65_plls[i][j].p) {
> +				case SAMA7D65_PLL_PARENT_MAINCK:
> +					parent_hw = sama7d65_pmc->chws[PMC_MAIN];
> +					break;
> +				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
> +					parent_hw = main_xtal_hw;
> +					break;
> +				default:
> +					/* Should not happen. */
> +					parent_hw = NULL;
> +					break;
> +				}
> +
> +				hw = sam9x60_clk_register_frac_pll(regmap,
> +					&pmc_pll_lock, sama7d65_plls[i][j].n,
> +					NULL, parent_hw, i,
> +					sama7d65_plls[i][j].c,
> +					sama7d65_plls[i][j].l,
> +					sama7d65_plls[i][j].f);
> +				break;
> +
> +			case PLL_TYPE_DIV:
> +				hw = sam9x60_clk_register_div_pll(regmap,
> +					&pmc_pll_lock, sama7d65_plls[i][j].n,
> +					NULL, sama7d65_plls[i][0].hw, i,
> +					sama7d65_plls[i][j].c,
> +					sama7d65_plls[i][j].l,
> +					sama7d65_plls[i][j].f,
> +					sama7d65_plls[i][j].safe_div);
> +				break;
> +
> +			default:
> +				continue;
> +			}
> +
> +			if (IS_ERR(hw))
> +				goto err_free;
> +
> +			sama7d65_plls[i][j].hw = hw;
> +			if (sama7d65_plls[i][j].eid)
> +				sama7d65_pmc->chws[sama7d65_plls[i][j].eid] = hw;
> +		}
> +	}
> +
> +	hw = at91_clk_register_master_div(regmap, "mck0", NULL,
> +					  sama7d65_plls[PLL_ID_CPU][1].hw,
> +					  &mck0_layout, &mck0_characteristics,
> +					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
> +	if (IS_ERR(hw))
> +		goto err_free;
> +
> +	sama7d65_pmc->chws[PMC_MCK] = hw;
> +	sama7d65_mckx[PCK_PARENT_HW_MCK0].hw = hw;
> +
> +	parent_hws[0] = md_slck_hw;
> +	parent_hws[1] = td_slck_hw;
> +	parent_hws[2] = sama7d65_pmc->chws[PMC_MAIN];
> +	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7d65_mckx); i++) {
> +		u8 num_parents = 3 + sama7d65_mckx[i].ep_count;
> +		struct clk_hw *tmp_parent_hws[8];
> +		u32 *mux_table;
> +
> +		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
> +					  GFP_KERNEL);
> +		if (!mux_table)
> +			goto err_free;
> +
> +		PMC_INIT_TABLE(mux_table, 3);
> +		PMC_FILL_TABLE(&mux_table[3], sama7d65_mckx[i].ep_mux_table,
> +			       sama7d65_mckx[i].ep_count);
> +		for (j = 0; j < sama7d65_mckx[i].ep_count; j++) {
> +			u8 pll_id = sama7d65_mckx[i].ep[j].pll_id;
> +			u8 pll_compid = sama7d65_mckx[i].ep[j].pll_compid;
> +
> +			tmp_parent_hws[j] = sama7d65_plls[pll_id][pll_compid].hw;
> +		}
> +		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> +			       sama7d65_mckx[i].ep_count);
> +
> +		hw = at91_clk_sama7g5_register_master(regmap, sama7d65_mckx[i].n,
> +						      num_parents, NULL, parent_hws,
> +						      mux_table, &pmc_mckX_lock,
> +						      sama7d65_mckx[i].id,
> +						      sama7d65_mckx[i].c,
> +						      sama7d65_mckx[i].ep_chg_id);
> +		if (IS_ERR(hw))

Missing kfree(mux_table);
(or move "alloc_mem[alloc_mem_size++] = mux_table;" before this test to 
have in done by the error handling path)

> +			goto err_free;
> +
> +		alloc_mem[alloc_mem_size++] = mux_table;
> +
> +		sama7d65_mckx[i].hw = hw;
> +		if (sama7d65_mckx[i].eid)
> +			sama7d65_pmc->chws[sama7d65_mckx[i].eid] = hw;
> +	}
> +
> +	parent_names[0] = "syspll_divpmcck";
> +	parent_names[1] = "usbpll_divpmcck";
> +	parent_names[2] = "main_osc";
> +	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
> +	if (IS_ERR(hw))
> +		goto err_free;
> +
> +	parent_hws[0] = md_slck_hw;
> +	parent_hws[1] = td_slck_hw;
> +	parent_hws[2] = sama7d65_pmc->chws[PMC_MAIN];
> +	parent_hws[3] = sama7d65_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw;
> +	parent_hws[4] = sama7d65_plls[PLL_ID_DDR][PLL_COMPID_DIV0].hw;
> +	parent_hws[5] = sama7d65_plls[PLL_ID_GPU][PLL_COMPID_DIV0].hw;
> +	parent_hws[6] = sama7d65_plls[PLL_ID_BAUD][PLL_COMPID_DIV0].hw;
> +	parent_hws[7] = sama7d65_plls[PLL_ID_AUDIO][PLL_COMPID_DIV0].hw;
> +	parent_hws[8] = sama7d65_plls[PLL_ID_ETH][PLL_COMPID_DIV0].hw;
> +
> +	for (i = 0; i < 8; i++) {
> +		char name[6];
> +
> +		snprintf(name, sizeof(name), "prog%d", i);
> +
> +		hw = at91_clk_register_programmable(regmap, name, NULL, parent_hws,
> +						    9, i,
> +						    &programmable_layout,
> +						    sama7d65_prog_mux_table);
> +		if (IS_ERR(hw))
> +			goto err_free;
> +
> +		sama7d65_pmc->pchws[i] = hw;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(sama7d65_systemck); i++) {
> +		hw = at91_clk_register_system(regmap, sama7d65_systemck[i].n,
> +					      sama7d65_systemck[i].p, NULL,
> +					      sama7d65_systemck[i].id, 0);
> +		if (IS_ERR(hw))
> +			goto err_free;
> +
> +		sama7d65_pmc->shws[sama7d65_systemck[i].id] = hw;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(sama7d65_periphck); i++) {
> +		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
> +							 &sama7d65_pcr_layout,
> +							 sama7d65_periphck[i].n,
> +							 NULL,
> +							 sama7d65_mckx[sama7d65_periphck[i].p].hw,
> +							 sama7d65_periphck[i].id,
> +							 &sama7d65_periphck[i].r,
> +							 sama7d65_periphck[i].chgp ? 0 :
> +							 INT_MIN, 0);
> +		if (IS_ERR(hw))
> +			goto err_free;
> +
> +		sama7d65_pmc->phws[sama7d65_periphck[i].id] = hw;
> +	}
> +
> +	parent_hws[0] = md_slck_hw;
> +	parent_hws[1] = td_slck_hw;
> +	parent_hws[2] = sama7d65_pmc->chws[PMC_MAIN];
> +	parent_hws[3] = sama7d65_pmc->chws[PMC_MCK1];
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


