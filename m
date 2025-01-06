Return-Path: <linux-spi+bounces-6224-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78120A0221F
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C93A11C4
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA61D6DA1;
	Mon,  6 Jan 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQwBt9Rx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1F1D89FE
	for <linux-spi@vger.kernel.org>; Mon,  6 Jan 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156839; cv=none; b=XG/Mmk86jYTulyVyOpsbxHSNMj6Ur22TNAH/uJ49hnctd0ozrsmPYOEPq7ImZqrpTCx4hoLmGWgN7ZCrW07lSd74BuLeP5Faw7yrFoHxJRtKyJsKh43QtKayOW/7vSn0K4IkFDIf769eX2XJxajqQd/XYB59KEE4EmEWpxdTnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156839; c=relaxed/simple;
	bh=4FeV6ZPr3jGASfKnVKZgWxePWMd6SkcF8XKyp9R5ZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MRpRmvgaRo9Bim9GWrfJzCRvOz+k4qKlcXqyeFll/+MBRJx33K6/qt83dV9Fa7M/uHRQZkf17vbpdJWthBD9Ivj/MYbj27ArrtwqPRNdqz9Pqaqipaz1y1+R3l9LrRrRixKc54Ju4Wek57o4tgaAn+PgsKx5BiE6wMkIrXwTD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQwBt9Rx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so7782151f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 06 Jan 2025 01:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736156836; x=1736761636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drQE5mfG6UfY6qmLY59TYj//IZAj9bk+9THlcgSH/G4=;
        b=LQwBt9Rx7NJPSocKRwze5M89V256yk4HNe9HD4d5nyucrgT8occFQq9LG0CFv+9ZZ9
         vQ6HZQeqn3uEn02IKCUCA1lV0InY8BxyIdA0/JFkwybgf5rfJ3Pt7b8fjYsQLLvKTHN0
         oLqUoPsCnXTRD6dGd6pXq++C8A/beWmDjDf8ny8ST5JL6/VG1ZGIg+mzqNJUGClLXF7Z
         0uHRng9h1r4AWXSJVHz2luYv+XsSpY+tbVgZ1Vk9Q6V8Vq09e74+OnKCDlX+1ThI9ct4
         bSBjZUP6ECkTUB23l7v1WABCD1JPZIIwfLIkhX422sssvSQ4rYhvHNgd1vWyZah0swyO
         cV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156836; x=1736761636;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drQE5mfG6UfY6qmLY59TYj//IZAj9bk+9THlcgSH/G4=;
        b=NId4NwbmGHd788koUNhdIKwUWudb/95Fv9btiG747qTxGNN2y9MoQmGJ8/23XmkG+U
         yxw+u5r3tlEJbJEOyLQElOxW/06HZiujS7hLxCdRN4CBfVvyi37iMcVUPWHlYzDQh1tZ
         EzEuqUDiibh+1MQpqTzTjnHFwg/9fBPk7MCRIgYc4jDovRzKvimL2VO5FHXhJpaS487a
         ggntvGdqvQil97SK7C6wHC8+fAzyk8OL5IZoErZ13DnfbejKj4L/+AdteWDMAfWoGnQn
         O+tH0hV8h2RGMXUQ9t3ic6Uyy9T60p9plbmvRu1v3rTXzw/muDWw83dfxZj4ehnoCOb6
         r5UA==
X-Forwarded-Encrypted: i=1; AJvYcCWW5BPxo/0Jc1rTuM70DZzTYfTzt5lSCcUCAQImyTyXQniu0cGLB88V94oD7qfemVZ6qkF600Gwajg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAWHrtgO1XjT7dACMLffZPY5Ag6E7EyY5Zt+vkgyNb0e6xin6
	WfWiLYxwmt50OrW4p7I5WimsE8vsUECdDZJ8UtKQ/gegfnsrZY4MJ+muFE0Az7M=
X-Gm-Gg: ASbGncuRmjI7vp5cMfe8hhBmMz58WKZT73G/xQeJDZdm04f234mHFbUHsSVDGkgiSY9
	1MM/nIf2cHOu1bSykUhIWH5mOV+5yxyvmPVGw4HUmhoWttU35842wLWI0zte6cSLHiBr5iiHcV6
	rkuKs4tEfPiC9kN6onPbL+Z9DqpJp42NDRXQ3En3wJH9SpptDe01JePPtJ9LVjVPfUka08r+/6S
	F7TcKIDxN7qHHFp04lU1sbO+xWbOKhbE/L+sQ4T8WIRYOpWmL7H5mU4X7OX6Q==
X-Google-Smtp-Source: AGHT+IE1QA9GPbRGZrUYTaXeGGbTxlnKdAg52i/b75L7wR5SaTyuDJ7JMDNCeaS8O+uXqqVvObeBRQ==
X-Received: by 2002:a05:6000:156b:b0:385:e30a:e0f7 with SMTP id ffacd0b85a97d-38a221fab38mr48263786f8f.22.1736156835874;
        Mon, 06 Jan 2025 01:47:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm46740074f8f.106.2025.01.06.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:47:15 -0800 (PST)
Date: Mon, 6 Jan 2025 12:47:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, mtk22730 <Cloud.Zhang@mediatek.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Cloud Zhang <cloud.zhang@mediatek.com>
Subject: Re: [PATCH] [v1] spi: spi-mtk-nor: Modify the clock architecture of
 nor controller
Message-ID: <63ddb297-822c-47bd-a33b-e2203fe1fad1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212092206.14071-1-Cloud.Zhang@mediatek.com>

Hi mtk22730,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mtk22730/spi-spi-mtk-nor-Modify-the-clock-architecture-of-nor-controller/20241212-172704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241212092206.14071-1-Cloud.Zhang%40mediatek.com
patch subject: [PATCH] [v1] spi: spi-mtk-nor: Modify the clock architecture of nor controller
config: parisc-randconfig-r073-20241223 (https://download.01.org/0day-ci/archive/20241223/202412232136.cWvRuwoD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412232136.cWvRuwoD-lkp@intel.com/

smatch warnings:
drivers/spi/spi-mtk-nor.c:746 mtk_nor_parse_clk() warn: impossible condition '(cnt == -22) => (1-255 == (-22))'

vim +746 drivers/spi/spi-mtk-nor.c

87d65a23444841 Cloud Zhang   2024-12-12  738  static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
87d65a23444841 Cloud Zhang   2024-12-12  739  {
87d65a23444841 Cloud Zhang   2024-12-12  740  	struct device_node *np = dev->of_node;
87d65a23444841 Cloud Zhang   2024-12-12  741  	int ret;
87d65a23444841 Cloud Zhang   2024-12-12  742  	const char *name;
87d65a23444841 Cloud Zhang   2024-12-12  743  	u8 cnt, i;
                                                ^^^^^^

87d65a23444841 Cloud Zhang   2024-12-12  744  
87d65a23444841 Cloud Zhang   2024-12-12  745  	cnt = of_property_count_strings(np, "clock-names");
87d65a23444841 Cloud Zhang   2024-12-12 @746  	if (!cnt || (cnt == -EINVAL)) {
                                                             ^^^^^^^^^^^^^^
cnt needs to be declared as an int.

87d65a23444841 Cloud Zhang   2024-12-12  747  		dev_err(dev, "Unable to find clocks\n");
87d65a23444841 Cloud Zhang   2024-12-12  748  		ret = -EINVAL;
87d65a23444841 Cloud Zhang   2024-12-12  749  		goto out;
87d65a23444841 Cloud Zhang   2024-12-12  750  	} else if (cnt < 0) {
                                                           ^^^^^^^
It's weird that this doesn't trigger a warning.

87d65a23444841 Cloud Zhang   2024-12-12  751  		dev_err(dev, "Count clock strings failed, err %d\n", cnt);
87d65a23444841 Cloud Zhang   2024-12-12  752  		ret = cnt;
87d65a23444841 Cloud Zhang   2024-12-12  753  		goto out;
87d65a23444841 Cloud Zhang   2024-12-12  754  	} else if (cnt > MAX_CLOCK_CNT) {
87d65a23444841 Cloud Zhang   2024-12-12  755  		ret = -EINVAL;
87d65a23444841 Cloud Zhang   2024-12-12  756  		goto out;
87d65a23444841 Cloud Zhang   2024-12-12  757  	}
87d65a23444841 Cloud Zhang   2024-12-12  758  
87d65a23444841 Cloud Zhang   2024-12-12  759  	sp->clock_cnt = cnt;
87d65a23444841 Cloud Zhang   2024-12-12  760  
87d65a23444841 Cloud Zhang   2024-12-12  761  	for (i = 0; i < cnt; i++) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


