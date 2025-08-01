Return-Path: <linux-spi+bounces-9261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51BB18212
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58461C25EF3
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D719F13F;
	Fri,  1 Aug 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPmJldVP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34871798F
	for <linux-spi@vger.kernel.org>; Fri,  1 Aug 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053354; cv=none; b=UWmVF830uptzw7o9kEneUnWnPBILotTK6xu0COdVzfSazamv7EdEwU+nvv1qEos3BGl01lscf5r5XTK+3YokYj23CU482iw2b7JsVmDfb9NLatSkpD2i8zTaTJyOYFgbdavmzvGuMvee3CUrJN2bnDSEsRbCWfUwHTBWMKyFLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053354; c=relaxed/simple;
	bh=cEOvsUYn/WTGd1XAM4acl+wyZ7cok9v5z+OAnRol8YA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IcIADT8p4JpG5PEm4WYuWVN6bUQL4PbkOMjOCu8JMLxTKadNhAB+I7fcDdWurb8kHKEczgeuvZd1uTRGY2/a5j0Jb16djj44KfeNTXOV10s/S6Jib4cvLt96waCCkera0u/mRDA+Yv7SZrxuD8dJbJEtzCPjITLqJeYHGtyfkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPmJldVP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so830768f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 01 Aug 2025 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754053351; x=1754658151; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLMMegKWPAwbuAT4qa7ry5UgyjMvX8MthgDNa8ZNhbc=;
        b=xPmJldVPOpJxkrcwIHPrfmsImiEZFVr0sN3vvySn8ktK/dAd2sJ5o+shgA4PK4fNRr
         lP1R5174l4HZTb0mOx4Yr7wxMtmh9fmvze3Pn5Isc6G1Jm8OojB0iK668xYuFUvw0Vy0
         jGj6HLhQaiGXU0DPe6WhvlkjDiwPYQxIMZGiyJVWFU3Vu1MkCvWoWaBaBcwbm/gdWVZ8
         +rmPEoomxdnWd8Fz6+cUU2SfSd2FY1eSQ5L0Q3G24gvZvGCreUTdqbA1iFTgQdy1MA66
         TN3n4QKbwEIulLlN9LihsysQigW3LulWOgQAjglejXjWUKWiuqlV+XfObxUgKy7nbirM
         rzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053351; x=1754658151;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLMMegKWPAwbuAT4qa7ry5UgyjMvX8MthgDNa8ZNhbc=;
        b=vYtNen7CQtOzrNlj3wi6bxIayO8uIIG4tQFeKsgVIiEH+8FTEkC6AAzOeg8OrCarcD
         5DUdr9M21MIac8KbBiAtrf6XcH2uRWMwbtodZnNTVdpWIf6/KsxEaNCXZK2rUgBzQTAy
         MFOQy8d9kKDRTqaCKGGRVogAtATJFUU3TxkxcJH6js9EpDk7b4xYVCkepAt917Zj6ml1
         /u3YBrsOiytEv4BGor9/aSF9i1WST7LfQZbjrhm3G016fnmEr+SNamv3VofHduPmJhaa
         iDUnS00hWNbeRLGk8QsspIeBQzrxLaadiP/22lY2CHCcHMieDjZJzkS+BKmSfonq+0mo
         r22A==
X-Forwarded-Encrypted: i=1; AJvYcCWDhJepgbrvIrxkMcVWZWdY8zjGPJZPYksLmaT3rOwZMEvmXwyaZhD15N2a9Fqh3jh406sdao6jQCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyghDjVfX/F7JSJIBZCjZDW6qOXG5cHkWdHOgyVLSW/LiBviaQO
	x2xGnNUXE3hUTrhvXSScS0+De7pnGFIScGQahmzqx8SPxThas+NnshCH7UI4JGwooxU=
X-Gm-Gg: ASbGncvh1gWn7I/GsuFNRH0JLoypN/tBl1+hanUXpYn/D6nMB4vrKjIxzt30GuGOABI
	3TvasxSGfFDhgdT4b2puPodHGFxDGpEwze0ZQGYTqNh4gafKNib6dytD+sYcymV7fHF++1b7hij
	N+ObUFiQABbbIbSorF09PRoDwEuCHpAGOceXz8+vrCqLHPnFfGaI/lHExlqkbzI4uprH2SHRL6Y
	a3ztKLKPM1T5XJ9xvgMBBJDzFt51mfhRaojMu34IefyxOb5ANRQsLgBWyUXJg6hXe40wXwg6MDP
	e6NRO/nziS55hgarv1q1YM1gxdo4y+MpPxf7H1BzSR7PEA6DjCt7FScrRBrLVE3ESFAltD3jz5C
	whr3v0clyAP5/1qHhauzljSkeoWWRYibO5S1WPQ==
X-Google-Smtp-Source: AGHT+IF6UIhzEv/BIKAVKHHuy1yN8mG09Jf9PwNyU+wKaH+xagJfNv3fil+yZcyBDIY076Ap5Oe2Jw==
X-Received: by 2002:a5d:5f47:0:b0:3b8:d1a4:bab9 with SMTP id ffacd0b85a97d-3b8d349cecamr1926931f8f.45.1754053351081;
        Fri, 01 Aug 2025 06:02:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3c4d02sm5751772f8f.33.2025.08.01.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:02:30 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:02:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunny Luo <sunny.luo@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [bug report] spi: Add Amlogic SPISG driver
Message-ID: <aIy64j1zj316IF_h@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sunny Luo,

Commit cef9991e04ae ("spi: Add Amlogic SPISG driver") from Jul 18,
2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/spi/spi-amlogic-spisg.c:652 aml_spisg_clk_init()
	warn: passing zero to 'PTR_ERR'

drivers/spi/spi-amlogic-spisg.c
    640 static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
    641 {
    642         struct device *dev = &spisg->pdev->dev;
    643         struct clk_init_data init;
    644         struct clk_divider *div;
    645         struct clk_div_table *tbl;
    646         char name[32];
    647         int ret, i;
    648 
    649         spisg->core = devm_clk_get_enabled(dev, "core");
    650         if (IS_ERR_OR_NULL(spisg->core)) {

This should just be an IS_ERR() check...

    651                 dev_err(dev, "core clock request failed\n");

Otherwise, let's pretend that devm_clk_get_enabled() could really return
NULL because there was a bug in the Kconfig or somewhere else, then it
would need to be treated as success

--> 652                 return PTR_ERR(spisg->core);

This returns success, so I guess that would be fine except that really
it's not fine at all.

For more information see my blog:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

    653         }
    654 
    655         spisg->pclk = devm_clk_get_enabled(dev, "pclk");
    656         if (IS_ERR_OR_NULL(spisg->pclk)) {
    657                 dev_err(dev, "pclk clock request failed\n");
    658                 return PTR_ERR(spisg->pclk);

Same.

    659         }
    660 
    661         clk_set_min_rate(spisg->pclk, SPISG_PCLK_RATE_MIN);
    662 
    663         clk_disable_unprepare(spisg->pclk);
    664 
    665         tbl = devm_kzalloc(dev, sizeof(struct clk_div_table) * (DIV_NUM + 1), GFP_KERNEL);
    666         if (!tbl)
    667                 return -ENOMEM;
    668 
    669         for (i = 0; i < DIV_NUM; i++) {
    670                 tbl[i].val = i + SPISG_CLK_DIV_MIN - 1;
    671                 tbl[i].div = i + SPISG_CLK_DIV_MIN;
    672         }
    673         spisg->tbl = tbl;
    674 
    675         div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
    676         if (!div)
    677                 return -ENOMEM;
    678 
    679         div->flags = CLK_DIVIDER_ROUND_CLOSEST;
    680         div->reg = base + SPISG_REG_CFG_BUS;
    681         div->shift = __bf_shf(CFG_CLK_DIV);
    682         div->width = CLK_DIV_WIDTH;
    683         div->table = tbl;
    684 
    685         /* Register value should not be outside of the table */
    686         regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
    687                            FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN - 1));
    688 
    689         /* Register clk-divider */
    690         snprintf(name, sizeof(name), "%s_div", dev_name(dev));
    691         init.name = name;
    692         init.ops = &clk_divider_ops;
    693         init.flags = CLK_SET_RATE_PARENT;
    694         init.parent_data = &(const struct clk_parent_data) {
    695                                 .fw_name = "pclk",
    696                            };
    697         init.num_parents = 1;
    698         div->hw.init = &init;
    699         ret = devm_clk_hw_register(dev, &div->hw);
    700         if (ret) {
    701                 dev_err(dev, "clock registration failed\n");
    702                 return ret;
    703         }
    704 
    705         spisg->sclk = devm_clk_hw_get_clk(dev, &div->hw, NULL);
    706         if (IS_ERR_OR_NULL(spisg->sclk)) {

Same.

    707                 dev_err(dev, "get clock failed\n");
    708                 return PTR_ERR(spisg->sclk);
    709         }
    710 
    711         clk_prepare_enable(spisg->sclk);
    712 
    713         return 0;
    714 }

regards,
dan carpenter

