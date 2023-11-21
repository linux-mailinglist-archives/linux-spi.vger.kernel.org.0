Return-Path: <linux-spi+bounces-9-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B517F2858
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8661C20CED
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38091FA7;
	Tue, 21 Nov 2023 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70C97;
	Tue, 21 Nov 2023 01:06:57 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r5Mia-0005fz-Ne; Tue, 21 Nov 2023 10:06:52 +0100
Message-ID: <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
Date: Tue, 21 Nov 2023 10:06:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Content-Language: en-US, de-DE
To: Francesco Dolcini <francesco@dolcini.it>,
 Stefan Moring <stefan.moring@technolution.nl>
Cc: linux@bigler.io,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700557617;7b5ce5aa;
X-HE-SMSGID: 1r5Mia-0005fz-Ne

On 20.11.23 18:48, Francesco Dolcini wrote:
> On Mon, Nov 20, 2023 at 04:30:15PM +0100, Stefan Moring wrote:
>> Can you verify the values used for the transfer,  spi_imx->count and spi_imx->
>> bits_per_word inside the mx51_ecpsi_prepare_transfer() method? Those are the
>> only two things that changed in the commits. Maybe compare them to the working
>> version?
> 
> I would suggest to bisect the issue to the actual commit that
> introduced the regression, I do not think this was done yet.

I think it was. To quote

https://lore.kernel.org/all/8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com/

"'"
After upgrade from kernel 6.5.11 to 6.6.1 the spi-devices on my hw
colibri-imx6dl and verdin-imx8mm are not working anymore (TPM2 and
SPI-SRAM).

Analyzing the problem showed that the 2 commits introduced the problem:

spi: Increase imx51 ecspi burst length based on transfer length
15a6af94a2779d5dfb42ee4bfac858ea8e964a3f

spi: imx: Take in account bits per word instead of assuming 8-bits
5f66db08cbd3ca471c66bacb0282902c79db9274

Reverting the commits solved the problem.
"'"

Or am I missing something here?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

