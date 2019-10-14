Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6038D6A84
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2019 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfJNUDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Oct 2019 16:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfJNUDG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Oct 2019 16:03:06 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D39121835;
        Mon, 14 Oct 2019 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571083385;
        bh=GBKs3pYf0OZ6wVLDCz6DD6bu1uL/o44+keF7d0WO1fM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yNdvcbFFVoNE4IozUPaq4o6qXY9JDqbmNTyPvO5BdLRzxng2UAC83+WcqgdiSSk4t
         J/S7LuvQxHcyln/Uaed9G/ws3cbts0Y9ylghDafyLKVJnoEV+7hhW89MxMYi9T7Akr
         ywRdKhdLER2uXRavKAvRzJfPeLYUs7V5Zh4nzXr0=
Received: by mail-qt1-f174.google.com with SMTP id m61so27136055qte.7;
        Mon, 14 Oct 2019 13:03:05 -0700 (PDT)
X-Gm-Message-State: APjAAAVAgaRQxJgOQ6kVCxXsU1WRsv69hU40wK0z49yRpVFlsMD+j5bY
        mTXx84osYV06abuoC6gNhXeqSPCAMO08quYdqg==
X-Google-Smtp-Source: APXvYqzzFryrBUBHPqhBav6IieLfGtzdLNcRbdJQP3SnrJSLC+4nEdQRGsGKczUDxbaXtr2AewTHbvHZUWfAiVMAgh0=
X-Received: by 2002:ac8:35ba:: with SMTP id k55mr35040431qtb.110.1571083384564;
 Mon, 14 Oct 2019 13:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190926102533.17829-1-horms+renesas@verge.net.au>
 <20191014195451.GA22084@bogus> <20191014195844.GE4826@sirena.co.uk>
In-Reply-To: <20191014195844.GE4826@sirena.co.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Oct 2019 15:02:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJe0+QHs=jfF8e6rSJMAy8=UpbtdPqy6aP2LeEQ974Hog@mail.gmail.com>
Message-ID: <CAL_JsqJe0+QHs=jfF8e6rSJMAy8=UpbtdPqy6aP2LeEQ974Hog@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: sh-msiof: Convert bindings to json-schema
To:     Mark Brown <broonie@kernel.org>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 14, 2019 at 2:58 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 14, 2019 at 02:54:51PM -0500, Rob Herring wrote:
> > On Thu, 26 Sep 2019 12:25:33 +0200, Simon Horman wrote:
> > > Convert Renesas HSPI bindings documentation to json-schema.
> > > Also name bindings documentation file according to the compat string
> > > being documented.
>
> > Applied, thanks.
>
> I've been sitting on this (and another ASoC conversion) waiting for you
> to review them - in particular with this one I've got another patch
> queued up which depends on it so it'd be good to apply it to my tree.

Okay, dropped then.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
