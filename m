Return-Path: <linux-spi+bounces-8902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48EAEDC33
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520753B370B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97C289829;
	Mon, 30 Jun 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="D1hgo3sd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C5132103;
	Mon, 30 Jun 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284965; cv=none; b=AHtYCIOZdPqSc0wf3sWXQxJQxg3J/F4aP7U0+PKLuEk7SaxuWYawSHRG2lBVeEAP53vRNEfv3N0WsDpqQDfz8EvTokq9q3skkjnQuTnkAUU4ODXfLyYS5tKNKUKATzO8Yd/1NwOJBMt8Cb/OnQr4ibT9sBC2BPQ1uIGhWegACU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284965; c=relaxed/simple;
	bh=U1QgVE73GMBK0qSO6uHgXRDTMZCMdlmK0zuJgUetxII=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SVTd/JifMtYEcEUBYXGvY/5ZXh5kNs+LnWVsPs4Yv+poRJxq4a/mWwx1aOgr93WTwlJ241BoxKpX0y0sEMrk5GEx3uFAG+iQtoRMZB1pG5gUNAL64Rw3ZPD0XkAOow5lColeRfI0VFNaOwFavQEs9U+TPvubs/llnM9MaKtzV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=D1hgo3sd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UAmwnf029679;
	Mon, 30 Jun 2025 14:02:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	v1NgvuOJViNQoQa3YdxL37LV+10hlKR/k1LPKw76dTU=; b=D1hgo3sdFbaC2Bbs
	9lLvzpaYsrXuOOHj40rLw8GUtIv69bF8So+wuyY4i5FosAPKndrnwhtcTubgkesG
	csIa/1FLZkF6RZKb/OOaXseiCArM5OmD37WhIZ1Zqfk9vLAtvqYfnTI9sUhVULh9
	TmXkQVS7m2hYFDwlkSZky7qd0ZC/rmGeMtplj5c2oOcPavL9o8QZmMC9/U8LN4gY
	mJS4QjM9A5IPrYet6UyalO/UwZspUccurR++cth9P0Y73MpzwDRHSRymCf9G1LxP
	SLspA/qgYu9rujKTdNHXO+yFWu9XeTMDd0yadDs6S1T+Sly0nCl4nWgLCmcghLja
	nPr6Ag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jubnmt6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 14:02:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0EA24004D;
	Mon, 30 Jun 2025 14:01:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E2415B2B8D1;
	Mon, 30 Jun 2025 14:00:51 +0200 (CEST)
Received: from [10.252.20.7] (10.252.20.7) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 14:00:51 +0200
Message-ID: <3d4d0eb4-a9ec-4fb2-be9c-4d8999cfeebb@foss.st.com>
Date: Mon, 30 Jun 2025 14:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
To: Mark Brown <broonie@kernel.org>
CC: Antonio Quartulli <antonio@mandelbit.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>
References: <20250630081253.17294-1-antonio@mandelbit.com>
 <5e61da51-cd02-41fd-9773-8bd776e1db62@foss.st.com>
 <192fb276-1e5a-4f69-8815-133f6bcd36b3@sirena.org.uk>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <192fb276-1e5a-4f69-8815-133f6bcd36b3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01

On 6/30/25 13:20, Mark Brown wrote:
> On Mon, Jun 30, 2025 at 10:28:50AM +0200, Clement LE GOFFIC wrote:
> 
>> Thank you, LGTM
>> You can add my Reviewed-by
> 
> If you want to add a Reviewed-by you should actually write it out in the
> mail, people rely on tooling like b4 to pick them up.

Yes, sorry.
Fixed it.

Best regards,
Clément

