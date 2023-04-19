Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56B66E8515
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjDSWkq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Apr 2023 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDSWkl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Apr 2023 18:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B410E3
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681943881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oV6dPbj6v5bxxtQ0bf2vQ9h1B33hpQZo734sVJEIFy0=;
        b=MS+2QKlY12XgdTGOXnyWBWmXgN2fV0NbKB//hr/Rco03MNliMpwVPlHSNnBKF/sUx0q1/9
        sdGVCYaAh1yT2RxjBHJflXQtB58h9CJbOwfaomv8Vvw3FqcE8vyBdVMdcTQJrDehdlW8eN
        XX50/YKZ7XAqKXgbGsbc9OEbsC+FN8U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Kr9-mK_EPDq8Org0qAEbeQ-1; Wed, 19 Apr 2023 18:34:35 -0400
X-MC-Unique: Kr9-mK_EPDq8Org0qAEbeQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1a6a0962beaso2388015ad.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 15:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943674; x=1684535674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV6dPbj6v5bxxtQ0bf2vQ9h1B33hpQZo734sVJEIFy0=;
        b=QAgHsd0pFVO+1gojEi9s8bCmzywUohoEHbgwTH6wV942z+QFosmFyvZQzbJO6fZrJP
         ZRYEqOd0P/ZP9/xV2n2XI17ge5Y/y2EUH5pVjAJu9WzQYIcdxoIak4j8NxxESiMbY/H9
         u8z+GX6fdFJBKpHZHWsCBXzSJui8XJMplHqat2WBSeWzqYfOuTrutWmRM9LrUuEmmh3J
         MXdPGoWxt1RC/FUGOBPs/XXrkCxZ/F8CJdA73KqwKPP0CqQZOphtiZueXOWgDrUyymvY
         vOnKKJDzZB8PAGJFJrwB+hK6MFp/dHtZGJMpd11NpbTI/fa/DfjKLy3KDAyjo45M3sJ5
         e/kg==
X-Gm-Message-State: AAQBX9cljN/fzFCx8uCEkgbKBBh/EPGkhMHWyetViSl3fKL0Fpw81CQO
        7MheSjpmk6AR0fZAKwDE12DQuHF0v4PxD2X5cl/CTKu3XhhcG+Wx+LrBaRs480v4dO3HZIAyOnf
        Kbz7ytuZ27i44jvrnlCM2
X-Received: by 2002:a17:902:e80a:b0:1a2:9051:f09e with SMTP id u10-20020a170902e80a00b001a29051f09emr7910425plg.21.1681943674327;
        Wed, 19 Apr 2023 15:34:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YRcOJA9m4//sCD7nyS42bqaIK5+K28VX9KwVstfAjYABbGiPZuMs419sXFFAlB2owlcVEoOw==
X-Received: by 2002:a17:902:e80a:b0:1a2:9051:f09e with SMTP id u10-20020a170902e80a00b001a29051f09emr7910402plg.21.1681943673995;
        Wed, 19 Apr 2023 15:34:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id je13-20020a170903264d00b001a1b808c1d8sm11889776plb.245.2023.04.19.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:34:33 -0700 (PDT)
Date:   Wed, 19 Apr 2023 15:34:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V8 1/3] spi: Add TPM HW flow flag
Message-ID: <ipj7gegcsrrha6xy5otn5afauskg7e6gv3aj4f52ee2fzuosmb@mr6nr6gsebtw>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
 <20230302041804.24718-2-kyarlagadda@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230302041804.24718-2-kyarlagadda@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 02, 2023 at 09:48:02AM +0530, Krishna Yarlagadda wrote:
> TPM specification [1] defines flow control over SPI. Client device can
> insert a wait state on MISO when address is transmitted by controller
> on MOSI. Detecting the wait state in software is only possible for
> full duplex controllers. For controllers that support only half-
> duplex, the wait state detection needs to be implemented in hardware.
> 
> Add a flag SPI_TPM_HW_FLOW for TPM device to set when software flow
> control is not possible and hardware flow control is expected from
> SPI controller.
> 
> Reference:
> [1] https://trustedcomputinggroup.org/resource/pc-client-work-group-
> pc-client-specific-tpm-interface-specification-tis/
> 

Minor thing, but should this reference the newer specification [1]?

[1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/


Regards,
Jerry

> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  include/linux/spi/spi.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4fa26b9a3572..b9e49ed42955 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -184,8 +184,18 @@ struct spi_device {
>  	u8			chip_select;
>  	u8			bits_per_word;
>  	bool			rt;
> -#define SPI_NO_TX	BIT(31)		/* No transmit wire */
> -#define SPI_NO_RX	BIT(30)		/* No receive wire */
> +#define SPI_NO_TX		BIT(31)		/* No transmit wire */
> +#define SPI_NO_RX		BIT(30)		/* No receive wire */
> +	/*
> +	 * TPM specification defines flow control over SPI. Client device
> +	 * can insert a wait state on MISO when address is transmitted by
> +	 * controller on MOSI. Detecting the wait state in software is only
> +	 * possible for full duplex controllers. For controllers that support
> +	 * only half-duplex, the wait state detection needs to be implemented
> +	 * in hardware. TPM devices would set this flag when hardware flow
> +	 * control is expected from SPI controller.
> +	 */
> +#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM HW flow control */
>  	/*
>  	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
>  	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
> @@ -195,7 +205,7 @@ struct spi_device {
>  	 * These bits must not overlap. A static assert check should make sure of that.
>  	 * If adding extra bits, make sure to decrease the bit index below as well.
>  	 */
> -#define SPI_MODE_KERNEL_MASK	(~(BIT(30) - 1))
> +#define SPI_MODE_KERNEL_MASK	(~(BIT(29) - 1))
>  	u32			mode;
>  	int			irq;
>  	void			*controller_state;
> -- 
> 2.17.1
> 

