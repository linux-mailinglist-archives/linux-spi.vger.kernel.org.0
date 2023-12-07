Return-Path: <linux-spi+bounces-170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A08091ED
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D51C2091F
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E84F8BA;
	Thu,  7 Dec 2023 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b="Db/3hWY1"
X-Original-To: linux-spi@vger.kernel.org
X-Greylist: delayed 547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 11:53:00 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55CE10F7;
	Thu,  7 Dec 2023 11:53:00 -0800 (PST)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4SmPpZ6nl2z42BL;
	Thu,  7 Dec 2023 20:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
	t=1701978231; bh=5CPVKu3TxDl2wV6vKgod10Z8n+KlCGb1R1OHdFqnin0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Db/3hWY1g+SqDVVRF2axsJpARayotSc9VQvX5AQ//LD6IwTTHDne8S0rX3KOyuT2F
	 WZm9BcyWZIW7zUKZdjceSzQyghlqO9v5PJBnMlebT3R/YugV3IY0osvtvEh/igAX+7
	 do8KFzDSEdkZe3mQ1JpYDNbMPTzGEyD/N0oxBh8pA0zjfSVuyd+pdmWN4ewLOQK30e
	 p1WDBm8QYn7WfLaaOmG2yiTWOzOhq9FoqgBB9ZIWPAAzzKZ1MOqUfInyXf2Dv67lom
	 n/CVAAfk8cVfljIgmuF9JKm7lDTE0EdRnfCU65qy4W93aIYRin4NoivgPqkvq4ZLU6
	 g8NC/rpCwu3oQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4SmPpZ6QClz7wg2;
	Thu,  7 Dec 2023 20:43:50 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4SmPpZ3QR0z8sZf;
	Thu,  7 Dec 2023 20:43:50 +0100 (CET)
Received: from [192.168.1.24] (xdsl-188-155-37-14.adslplus.ch [188.155.37.14])
	by mx2fc6.netcup.net (Postfix) with ESMTPSA id 6F0C640F9E;
	Thu,  7 Dec 2023 20:43:45 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 188.155.37.14) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <a04f6a3d7e2850be95ce37aac2a66dbd1332121d.camel@bigler.one>
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From: Benjamin Bigler <benjamin@bigler.one>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	linux@bigler.io
Cc: broonie@kernel.org, francesco@dolcini.it, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, stefan.moring@technolution.nl
Date: Thu, 07 Dec 2023 20:43:34 +0100
In-Reply-To: <6c97a39b-4ba6-4d79-985e-a69f8e0c76a4@leemhuis.info>
References: <c7a38307ac74a973e26ac820a0b98773262720bd.camel@bigler.one>
	 <89209fbb46c4ce650141ecb6fdf06476@mail.infomaniak.com>
	 <6c97a39b-4ba6-4d79-985e-a69f8e0c76a4@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-PPP-Message-ID: <170197822595.7928.16810283797967606440@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: 6F0C640F9E
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 8IopcNRxVMRSnN5hUGGwD9GhXYJ/eoE16xC7clBgLKEenUE=

> > On 27.11.23 10:09, linux@bigler.io wrote:
> > > >=20
> > > > Thank you Benjamin for the patch.
> > > > I have tested the patch and is works fine.
> >=20
> > That's great.
> >=20
> > Benjamin, what's the status of the fix for this regression? I tried to
> > find a proper submission for review, but didn't find one. Am I missing
> > something or did that fall through the cracks?

I haven't send a proper patch yet. I will read through the guidelines and
submit one on the weekend.

> >=20
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> >=20
> > #regzbot poke
> >=20
>=20

Best regards,
Benjamin Bigler

