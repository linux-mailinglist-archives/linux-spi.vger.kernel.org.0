Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D113465A59
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbhLBAHr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 19:07:47 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41692 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbhLBAHe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 19:07:34 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so37615610otl.8;
        Wed, 01 Dec 2021 16:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8m5H1RjODYZOhcIY/5HbLIJ8TZJPXHrLEoJIdbP730=;
        b=KATOhSYE/Km3pnmTGzPxjplakUNMhMEjIbvv3Rb8ESCkTtWPPYswFce1/z/ZgbOrTw
         9fbv1nAE5gj7tumGaY2q1ZMDUyifk8GMktCWKIH3rl725OEwnFaKQLwNkyXPU55Rl/C2
         PRkMLp4Yw+wVdGSpMMIjuUSH98BIRVXcrWvdnRJw9i4BygjBPLjvkoIx6EF/bsaFFSI6
         46QlnvSdWXXjqsyJC0o3sIGcFyg1zYR/dB2oHxbFO35CJthJEaUknQL5H+RicGPYR/yL
         +CROXyrJuTJLive/WeXPHYbz+wgucw0vbx0rAUQ+K0Nnj4/uiPmuRUsmJDic+tjb6Gc7
         MhSg==
X-Gm-Message-State: AOAM530CSa8mfej/GkbUYt0tQxkNp0OTD05seFjgR3uoCQFbAtsN8xVY
        ilXdB4hGj6H4t41/qXwduVSj1Z+bNw==
X-Google-Smtp-Source: ABdhPJzykshZ3giZeAWDq/K9p7fhw01EHwjy9zgTWnMXk6d5kPQA4sI+Q/+IGbOe5wf/CozpMmwaWw==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr8464722otu.354.1638403452524;
        Wed, 01 Dec 2021 16:04:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e14sm616444oow.3.2021.12.01.16.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:04:11 -0800 (PST)
Received: (nullmailer pid 3265276 invoked by uid 1000);
        Thu, 02 Dec 2021 00:04:10 -0000
Date:   Wed, 1 Dec 2021 18:04:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 4/5] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <YagNemH3SYHQJBTs@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126163450.394861-5-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 26, 2021 at 05:34:49PM +0100, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.

I don't quite understand why this is in spi-controller.yaml.

Also, please see this series[1].

Rob

[1] https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/

