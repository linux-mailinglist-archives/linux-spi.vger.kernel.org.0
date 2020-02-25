Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B516EC8B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgBYRbk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 12:31:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46036 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBYRbk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 12:31:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so232706otp.12;
        Tue, 25 Feb 2020 09:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QS0K6caHcm4ENnIoTn05eBvdx/7W9kVs7Tic77EWV3U=;
        b=nXTVk2CXW9DCWQZJahPfRuzJORSuUNQh5tK+WuM03Ex0gW/O9MLcJW2beosFG3oqOg
         Rpa60w76YL7vppNDVffMtu4kktDjN36kUcLW3lf31MAZcePrNjFH1uKYQb1Inxi6Apgn
         B2321KO8isIV4jB9M2DVTqwADyjxC/4bfIFjkOirCoia/pgo8R6SQWJuqloWbCm5hBKX
         JSyi6MlC9NGqJO7ZuQ6fDquN+pNf8HEvVFPoBIVwS1NvOiDQdCa9Gi8LhClma21ZoNXA
         IcBqGYpJP9G2iEuWcO1o4QfhAdCCwMPS7nupLXB8grIQ3nTXgcV++2f3YnfesQmTsJ88
         TFFA==
X-Gm-Message-State: APjAAAVl1M16Mq41ffapx9X7XtPRUvMdal+Ov80n/bQwPSXJYuZmY5BX
        KjJU+sUmFwNQ2kSQyphyXQ==
X-Google-Smtp-Source: APXvYqwB2+0s7QgvbO4hUWGFqaHT7kZzFUz3IlneivicGP+fTVhYNubNwANumJrX5ONqlNtblqsZ9g==
X-Received: by 2002:a9d:7559:: with SMTP id b25mr44320296otl.189.1582651899014;
        Tue, 25 Feb 2020 09:31:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm5915266oth.9.2020.02.25.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:31:38 -0800 (PST)
Received: (nullmailer pid 2861 invoked by uid 1000);
        Tue, 25 Feb 2020 17:31:37 -0000
Date:   Tue, 25 Feb 2020 11:31:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Message-ID: <20200225173137.GA31830@bogus>
References: <20200215065826.739102-1-gch981213@gmail.com>
 <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 20, 2020 at 07:58:06AM +0800, Chuanhong Guo wrote:
> Hi!
> 
> On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie@kernel.org> wrote:
> > This is an ABI break so you shouldn't be doing this, if the existing
> > binding works it should continue to work.
> 
> The missing spi-max-frequency is the only part preventing old
> device tree to work with this driver.
> If the goal is to make existing dt binding work, I could patch dt using
> of_add_property in v2. I saw similar device tree patching for legacy
> bindings in pinctrl-single driver.

You should should really only need 'spi-max-frequency' if the max freq 
is less than the minimum of the host and device max freq.

Rob
