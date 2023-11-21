Return-Path: <linux-spi+bounces-10-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C17F2883
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38BF1C20E37
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995A32196;
	Tue, 21 Nov 2023 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB7E8;
	Tue, 21 Nov 2023 01:17:04 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3A3791F83F;
	Tue, 21 Nov 2023 10:17:01 +0100 (CET)
Date: Tue, 21 Nov 2023 10:16:57 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thorsten Leemhuis <regressions@leemhuis.info>, linux@bigler.io
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Stefan Moring <stefan.moring@technolution.nl>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
References: <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
 <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>

On Tue, Nov 21, 2023 at 10:06:51AM +0100, Thorsten Leemhuis wrote:
> On 20.11.23 18:48, Francesco Dolcini wrote:
> > On Mon, Nov 20, 2023 at 04:30:15PM +0100, Stefan Moring wrote:
> >> Can you verify the values used for the transfer,  spi_imx->count and spi_imx->
> >> bits_per_word inside the mx51_ecpsi_prepare_transfer() method? Those are the
> >> only two things that changed in the commits. Maybe compare them to the working
> >> version?
> > 
> > I would suggest to bisect the issue to the actual commit that
> > introduced the regression, I do not think this was done yet.
> 
> I think it was. To quote
Whoops, you are right.

> spi: Increase imx51 ecspi burst length based on transfer length
> 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
> 
> spi: imx: Take in account bits per word instead of assuming 8-bits
> 5f66db08cbd3ca471c66bacb0282902c79db9274

Do we know which one of those two commits introduces this regression?

Francesco


