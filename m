Return-Path: <linux-spi+bounces-2359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F68A6780
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B447A1F21B63
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0C8625F;
	Tue, 16 Apr 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="icenVUDp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27186636;
	Tue, 16 Apr 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261237; cv=none; b=QAASD+JMBAq6Zr8a6uvPh7stTkG2d/jg9fhCVdjUTr4M9PxRpWgp2OsXODU1zLx6l6x2Wdp3Xk89NMJ2AWM7RxPgXe+Z6Re2l/JNJxnOaV/Ts68JFi1r6qpK7GTDW4HKZswmbkFXL5/S1kxRnZcLXWy75Ddi0/MTMWmi/ddOe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261237; c=relaxed/simple;
	bh=nC7JiA/cXqKs6RORcgHbwIUgVTD3hQ1hmjEfLC6R5XU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5GNdB1nWr4P1yntZ357hK0RG3hPAvvY4PmL74nEygOysl0OaO6qjEwYNfPdY7JBo2ORsaEVz8nV0BW+gNmR1E2NXX+2sVCjDIvTXHh8R8DxVMcO3KpuTajYsY+GecIlk9CPJLK7H0HPN/8kkgBYRSJDOIU7Y2g1S+TV+yTP2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=icenVUDp; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G8jCQN025032;
	Tue, 16 Apr 2024 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=qaKa/ax9YUCV2avevDf3IRSvlWpJMxHUjfBp92XSa5o=; b=
	icenVUDpY0zafCZ5G4a2X292paHeVStAjgbtnZVOuTpzYurxKyUTMCEIUEBuztmy
	7lBixYNY8Fvm27X96MAkNMsCylchYrSOOfHSDucTZbbyAyfwsi11g+nRdd2wbV4U
	dmeWve7M8ljpZxtjuuOSq3bJSNo+iraTiI2BZBLN92iTqJI5vHcuLWO4QPrkTuKx
	sGuIEE6YQSJVDRH0m6i+d2vOrxNZ0VEl8BNQd28IvvCpmRI7Sjf7IbMZQhw9Iox+
	IkYswnXlrMhGQeHjUgTHIy9JXipKVc5WzA6OvEziwtKeI2aFdsGgCWaoL0en7j9Q
	8mjrb9ddr+6p/kBWHcb/Zg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyabw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 04:53:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 10:53:45 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 16 Apr 2024 10:53:45 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 7AFD0820244;
	Tue, 16 Apr 2024 09:53:45 +0000 (UTC)
Date: Tue, 16 Apr 2024 09:53:44 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v6 2/4] spi: Switch to using is_acpi_device_node() in
 spi_dev_set_name()
Message-ID: <Zh5KqNB0XaS2eV8j@ediswmail9.ad.cirrus.com>
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
 <20240415140925.3518990-3-ckeepax@opensource.cirrus.com>
 <CAHp75VdGq8L5ZQxo0BrC-TevY+pP2s0ZYkHcefjROvpf1+5MNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdGq8L5ZQxo0BrC-TevY+pP2s0ZYkHcefjROvpf1+5MNw@mail.gmail.com>
X-Proofpoint-GUID: 0HReWlhoBhl_ssEi6u95s62bOFOP-CHS
X-Proofpoint-ORIG-GUID: 0HReWlhoBhl_ssEi6u95s62bOFOP-CHS
X-Proofpoint-Spam-Reason: safe

On Mon, Apr 15, 2024 at 07:06:56PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2024 at 5:09 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > Use is_acpi_device_node() rather than checking ACPI_COMPANION(), such
> > that when checking for other types of firmware node the code can
> 
> a firmware node
> 

Pretty sure this parses better without the 'a'.

Thanks,
Charles

