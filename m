Return-Path: <linux-spi+bounces-12195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DCCF99F3
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00773131C36
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86834251C;
	Tue,  6 Jan 2026 17:05:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85447342177;
	Tue,  6 Jan 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719131; cv=none; b=N+vJOTWK3t2QAJrU/mSqKo7B72MC1Z4RNcEi9Q6cpFki0bYufPUALNoc3dsh+CcEtDQeCtQZ6KUbrD3Q+HWyMtgCiTBcDZscBQyg28nH8pun2A8PmPuhRUHYRnE8UCIphDybyJ+Ft+vLji2eh8Ah86OrXpBCZ6qmNzxuZ3E89qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719131; c=relaxed/simple;
	bh=FvvC6mlJwCFvpAh44L0gF6zkGXFMPkMCkLiTS9mJdKE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMxmckPltMdGSe+Ee9QuOJZk2jqkSpr12DFE5bsFJ+/iUUASJHmu25MK0SyEwYrKd+XAPNejH+0peaf+bFTZxzD7Cha0Lw6rdVTv4CmulfJcZZmcrOFWGC3z96Pxwr1iH/AVUSCWP7GPckUDVhwq4uaO9GNDdr5CobO4BL9+IVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlyGW6FwSzJ46YJ;
	Wed,  7 Jan 2026 01:05:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B96AC40086;
	Wed,  7 Jan 2026 01:05:25 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 17:05:25 +0000
Date: Tue, 6 Jan 2026 17:05:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alain Volmat <alain.volmat@foss.st.com>
CC: Mark Brown <broonie@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] drivers: spi: st: remove __maybe_unused for
 suspend/resume
Message-ID: <20260106170521.00001668@huawei.com>
In-Reply-To: <20260106-spi_st_maybe_unused_removal-v1-1-8f5ca7136e96@foss.st.com>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
	<20260106-spi_st_maybe_unused_removal-v1-1-8f5ca7136e96@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 6 Jan 2026 13:14:17 +0100
Alain Volmat <alain.volmat@foss.st.com> wrote:

> Remove useless __maybe_unused statements for suspend and resume
> functions since this is now used via pm_ptr.
Patch is fine, but reasoning not quite right. pm_ptr() allows
the dropping of the structure without needing a __maybe_unused
on that, but these are passed to the SYSTEM_SLEEP_PM_OPS()
macro and that is using pm_sleep_ptr().

So tiny description change needed to reflect that. Probably
mention the pm_sleep_ptr() is as part of the macro as that
bit is not totally obvious.

Jonathan


> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  drivers/spi/spi-st-ssc4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
> index c07c61dc4938..b173ef70d77e 100644
> --- a/drivers/spi/spi-st-ssc4.c
> +++ b/drivers/spi/spi-st-ssc4.c
> @@ -403,7 +403,7 @@ static int spi_st_runtime_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static int __maybe_unused spi_st_suspend(struct device *dev)
> +static int spi_st_suspend(struct device *dev)
>  {
>  	struct spi_controller *host = dev_get_drvdata(dev);
>  	int ret;
> @@ -415,7 +415,7 @@ static int __maybe_unused spi_st_suspend(struct device *dev)
>  	return pm_runtime_force_suspend(dev);
>  }
>  
> -static int __maybe_unused spi_st_resume(struct device *dev)
> +static int spi_st_resume(struct device *dev)
>  {
>  	struct spi_controller *host = dev_get_drvdata(dev);
>  	int ret;
> 


