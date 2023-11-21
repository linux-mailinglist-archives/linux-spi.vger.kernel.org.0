Return-Path: <linux-spi+bounces-11-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38517F29D3
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B0281608
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FCF38FB1;
	Tue, 21 Nov 2023 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
X-Greylist: delayed 91346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 02:10:24 PST
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DEC1;
	Tue, 21 Nov 2023 02:10:24 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E5732065C;
	Tue, 21 Nov 2023 11:10:22 +0100 (CET)
Date: Tue, 21 Nov 2023 11:10:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, linux@bigler.io,
	Stefan Moring <stefan.moring@technolution.nl>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVyCDGWhOSYFQADe@francesco-nb.int.toradex.com>
References: <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
 <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
 <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>

On Tue, Nov 21, 2023 at 10:16:57AM +0100, Francesco Dolcini wrote:
> On Tue, Nov 21, 2023 at 10:06:51AM +0100, Thorsten Leemhuis wrote:
> > spi: Increase imx51 ecspi burst length based on transfer length
> > 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
> > 
> > spi: imx: Take in account bits per word instead of assuming 8-bits
> > 5f66db08cbd3ca471c66bacb0282902c79db9274
> 
> Do we know which one of those two commits introduces this regression?

Whoops again. The second one is a fix for the first one, so my question
does not make any sense, forget about this, sorry.

Francesco


