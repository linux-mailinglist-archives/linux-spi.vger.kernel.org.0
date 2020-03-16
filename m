Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2126B186BA3
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCPNAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 09:00:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40739 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgCPNAQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 09:00:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id a24so21912059edy.7;
        Mon, 16 Mar 2020 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGW/IHmamfb5AlTYhmcZTb1SURVSQakTPzqAp6hWS1s=;
        b=O245OyKAMGDHtehBjleZdFAz910uOpYK3mJC1djuWEQjRF2YUTjWz4dQmBrCe8cgFF
         mhmaLSeR3hPDsDkcTHaJW521Wb02Vwvtg8IGWng89BTo57wDhgBDLB3Rq0lmembp6m+I
         mYsmk9VhsZyUQHrEizg10A+wcNEw+LAkL/4zxmOGHkrvV+dXLMm4S9ny/6UAjQ5OtXXj
         vVKMWPYGzJeeIKS7iMPCeyg4VSUEZU4f5lAfcIGQSEY9NiAlsfP6Z0kovt0Ae5duyAvb
         4oLd6Q6ZJ+TalM/MQLJwgDL58jASWYSuNwJTNwQuKkaqHzKZfoOMd3SMQGdIUFhqgT/8
         VhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGW/IHmamfb5AlTYhmcZTb1SURVSQakTPzqAp6hWS1s=;
        b=uddRkTgwu+J0g3R785ZupyVhApGY75rpvww34i2Y0oIpLSTmgndMQgtw55ECEtV6sw
         eLqaBPizsjkDnGziAM3fgcWu9nf/m6/4mbeyPwVg/XYkW9nUUxCE3otUSDk3CImezFG1
         eBF3tbpRZ2sLVnHFQG1lpCQ5xsnApI3tTzhRaMyt7FcoLCeE8ww8Qz2K7qASc2+UPgDW
         6O5SVtkefNPt240T+v9555yvBACqksEOPkex56FzxcmU9egR94DqiqDD74qQksPg2FjA
         KgGIPdg41WNCUCmm76v35lCIFWvowXrR3aB6n6A8XaQcH/9FCekFJC3KjTKcqNt8WH2l
         S/ow==
X-Gm-Message-State: ANhLgQ24otxgjt/Gm13MTCsCBgby4GIdC/q3UlrJCXM2EB7+75AFeupJ
        Cm0X7OqMfZ1o+qbVHVCAZMJFkxzQuL54OvQ6hCg=
X-Google-Smtp-Source: ADFU+vuFF8kxObxcwgPaNFJj+U1xonZBMwzYEbw3lKnLTglbzK4OWJWe8xUD7zVV4Dij+l6xb/rvQ5evCxoz1S/7nQU=
X-Received: by 2002:a17:906:9451:: with SMTP id z17mr4369711ejx.176.1584363614345;
 Mon, 16 Mar 2020 06:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk> <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk>
In-Reply-To: <20200316124945.GF5010@sirena.org.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 16 Mar 2020 15:00:03 +0200
Message-ID: <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
>
> > Correct, the real problem is that I forgot to add a Fixes: tag for
> > patch 5. I'll do that now.
>
> OK.  The series otherwise looked fine but I'll wait for testing.
> Michael, if there's issues remaining it might be good to get some
> Tested-bys for the patches prior to whatever's broken so we can get
> those fixes in (but obviously verifying that is work so only if you
> have time).

This time I verified with a protocol analyzer all transfer lengths
from 1 all the way to 256, with this script:

#!/bin/bash

buf=3D''

for i in $(seq 0 255); do
=C2=BB       buf=3D"${buf}\x$(printf '%02x' ${i})"
=C2=BB       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
5000000 -p "${buf}"
done

It looked fine as far as I could tell, and also the problems
surrounding Ctrl-C are no longer present. Nonetheless it would be good
if Michael could confirm, but I know that he's very busy too so it's
understandable if he can no longer spend time on this.

Thanks,
-Vladimir
