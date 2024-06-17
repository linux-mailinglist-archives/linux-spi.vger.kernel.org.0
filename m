Return-Path: <linux-spi+bounces-3413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D790A98B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7493A1C21700
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52D1922C9;
	Mon, 17 Jun 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ldSC//pc"
X-Original-To: linux-spi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC111288BD;
	Mon, 17 Jun 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616551; cv=none; b=mZq1lRs+muSgoECIOV/iZer5TK8xOzR4wbP2lJTryU/NHs4mjSnI5SfyuSG20KpNJQqwmxcHgVj7Y5GDg6Rwp2Pp8AvOLFNzFBu0SsWmHbKlAhscbbPJjy7q3pVqyWFMc24bP76BEwJylP60XyUeNWoH5nHPrP7SpantZ9Wi/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616551; c=relaxed/simple;
	bh=HZ/UTAshROOqgyvi8MzzZCcTl6EpUHJPAXf2QBcR/is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJPUHShn5iqMdvyt1Wl/Mbt3DftmPaOpBoD/wvUTd1/p85R97AQTpHvDZXiKoKSQPd8LBrYpeuLKi41tiRJxdYKz6GzGuxQwWQUQMNo8zaZNMD9pRuxMTF4HQqPDtFlYUqNS1lg1XSeWQorsYU2FLvU3Oe3ArhNJzhBYFepM7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ldSC//pc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G/12lrjs5yDx1fcebds1m2IA2pve+yjYe0GUgmbBDr0=; t=1718616550;
	x=1719048550; b=ldSC//pcXeur4aF0Wtlzbwp2BvjkW4IshjOFJ7I2e5tOltD2VlrnSXJQYXhMp
	G2kVgpH3mgqQlsaPiAcMcGtZwfEWkzS8T1xvjMFVnf+jDNohlNTO3FRoRr0g/IekdDhgPPl5bdv2x
	WnaK3PHpEobJg5SRzrCw/0D17pp3aaGE8wL4tjNSx6WZkUg5FmrjNSPoYJg1WhRtoFC1C4hUOx6Hb
	C92k4tvx9WGhf1mqR8tB0of54w7D+TTGGndw5bTJ5Zpcdqb3e70hbFiv3Z8KPZaMhT3npxNMS1yMw
	dY+lg/ybY3D6rvbZd+1VIZGwj0GRSXqdd+ooRt1PSvRt18g0tg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJ8fi-0001h2-Pw; Mon, 17 Jun 2024 11:29:06 +0200
Message-ID: <1b9852d1-4454-4f62-bd8a-fb6167dc0576@leemhuis.info>
Date: Mon, 17 Jun 2024 11:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] spi: omap2-mcspi: not working with kernel v6.10
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 joao.goncalves@toradex.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718616550;d30e9acd;
X-HE-SMSGID: 1sJ8fi-0001h2-Pw

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 12.06.24 19:00, João Paulo Gonçalves wrote:
> 
> It appears that omap2-mcspi broke on kernel v6.10. I was testing an EEPROM like
> SPI FRAM using this DT:
> 
> &main_spi1 {
> 	pinctrl-0 = <&pinctrl_spi1>,
> 		    <&pinctrl_gpio_4>;
> 	cs-gpios =  <&mcu_gpio0 4 GPIO_ACTIVE_LOW>;
> 	status = "okay";
> 
> 	fram@0 {
> 		compatible = "fujitsu,mb85rs256", "atmel,at25";
> 		reg = <0>;
> 		address-width = <16>;
> 		size = <32768>;
> 		spi-max-frequency = <33000000>;
> 		pagesize = <1>;
> 	};
> };
> 
> On kernel v6.9, spi works fine and is possible to read/write the FRAM. However,
> on kernel v6.10-rc3 it gives me an Oops after a timeout:
> [...]

Thx for the report. Hmm, no developer replied yet. I suspect that means
they have no idea what causes this. In that case the thing that really
helps would be if you could use a git bisection to find the change that
causes this.

Anyway, to ensure that does not fall though the cracks, let me add this
to the tracking:

#regzbot report ^
#regzbot introduced: v6.9..v6.10-rc3
#regzbot summary: spi: omap2-mcspi: omap2-mcspi broke, Oops after a timeout

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

