Return-Path: <linux-spi+bounces-4994-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC0986FA9
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F711C20B2A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF11AB51C;
	Thu, 26 Sep 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wjKdfKtS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9B18DF79;
	Thu, 26 Sep 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341837; cv=none; b=pMTOHhuFDkrrUbtdseLMsOYH/9hgHrN7+BL3q+Jx5K983WXz53BMi2k18h7W9NhYe34rqFtztEJAet/AGX2rbvAC1fL3monmRPEPWTUYyGlvAGk4gLBAYEbmRawtAg4HraxpEs+k6Rz1IyizPke5zJxnrBJw4XGkqx08dO8GRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341837; c=relaxed/simple;
	bh=OPXE0buB81Ggk/7NWWrIO9qpbeglDOvSvzdNpWcyTXA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QykHfmasgtYco+nQ0l5B/9mp7vsXSHFcXU7siq+tgomj45aHMC8XTibT+waOhwH7fpHDG69h1w931S+iC52UTTnOKkBUV5IZUmZuyVxcNSWCxAaH1j5CzLWU7fTMtRwCx1IRsOCKOUJ6Nssuop2pCjdxxm14BV9jqGruNSxahKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wjKdfKtS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727341833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1Bh419iJCJq7aTv/7zXzylF213yjL52FzGyJSDz29k=;
	b=wjKdfKtS4LgS/AB7jEZzttdioBm+TNozwK6xUrPsPMjrpu7K08vLnV4KP/9a+Ok9FqZ5w3
	KAuG1ZLAtgy/sRZj+jN9KMx8IYebOvWuLuioyXQbphOZXnwAqX9SX1kw/B6eD/0Xd5Byrs
	q26Rv+GGkYEj+UElREMIfzXOLhVdRfOHjK6X8STNJhFlMoGwTyy0lhQlwXV+fWxw0+3Lba
	iDMZHQK9QIfvaSb7748sWC/cu8FI8riQT4HG+QBHdUTasSsLGODN4HS1vJs8qckluzAqyH
	48kBtv+esaC93Bpwn5ZJL7fN4pUU5VIEe42ys3OXeBYmYMl45E19PECPtmTFLw==
Date: Thu, 26 Sep 2024 11:10:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: rockchip: Don't check for failed get_fifo_len()
In-Reply-To: <2382990.BjyWNHgNrj@phil>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
 <2382990.BjyWNHgNrj@phil>
Message-ID: <feb172d99662a72494863a5227e72855@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-09-26 10:55, Heiko Stuebner wrote:
> Am Donnerstag, 26. September 2024, 10:38:14 CEST schrieb Dragan Simic:
>> Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep 
>> FIFOs"),
>> function get_fifo_len() can no longer return zero, so delete the 
>> redundant
>> check for zero in function rockchip_spi_probe().
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> Didn't this topic come up in another recent patch too?

Hmm, perhaps, but I'm unaware of that patch?  Maybe I missed it.

> Anyway, having looked up the what the current get_fifo_len does,
> the 0 case should never happen, as you describe, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks.

