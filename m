Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5A33E198
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 23:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhCPWnn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 18:43:43 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:36280 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhCPWn1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 18:43:27 -0400
Received: by mail-il1-f175.google.com with SMTP id g9so14288478ilc.3;
        Tue, 16 Mar 2021 15:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1JUvYEIH9Ub70lK5Ho8Ghu0o2QmwUhPR7XOSE+miY0=;
        b=UYE2rCDlDNk3YDhnwKjTm539CEh85VIHQyBgv/i3Y6cGiwZgxl0GASm8QarWW50Cyv
         v+RZTtTOR2CZ2xDpWM1Wzsd4KA+n43nk1MfsprUKe1jbmE1lcfNdBcR4S+Xdrge/ZsG2
         X/UQQaxOlUMpC2dymFs21HyunibVXEX7DY+P1IZ2VOuX/vgBzDm9zW8qkBi+tVTYEFRl
         MAnBmo/kpwy3mmY9+uHzw3x8IOoqY5iYLaclyCqNIgLzrMLp+TuwsdB5/Kt8t07u+7hL
         G/97b0yUzLfaDlGgaYM6oouyhDcYTFLNU+8+wp54MV1PeSKJSQOgEgk0sxT3HBAIZSFs
         Tteg==
X-Gm-Message-State: AOAM530v4qryuEsg9WKAR/kwre5QEP7olTMvYb3wo11Q6AFJSx5u0JQy
        GrVqzSZSVAsGihdmvXugog==
X-Google-Smtp-Source: ABdhPJwFHCjxAZVnZHCADPsgnfi2hSs3Bx7sbtEZaIaGGInNNPtFF2oKacW1Qwq+Sje5/iOXTMeGdw==
X-Received: by 2002:a92:b749:: with SMTP id c9mr5575039ilm.155.1615934607311;
        Tue, 16 Mar 2021 15:43:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d10sm6802315ila.47.2021.03.16.15.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:43:26 -0700 (PDT)
Received: (nullmailer pid 3822922 invoked by uid 1000);
        Tue, 16 Mar 2021 22:43:24 -0000
Date:   Tue, 16 Mar 2021 16:43:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Message-ID: <20210316224324.GA3822887@robh.at.kernel.org>
References: <20210310165200.3560970-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310165200.3560970-1-kuldeep.singh@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 10 Mar 2021 22:22:00 +0530, Kuldeep Singh wrote:
> Convert the NXP FlexSPI binding to DT schema format using json-schema.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 85 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 43 ----------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 86 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
